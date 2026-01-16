import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:limen_app/domain/data/verse_repository.dart';
import 'package:limen_app/domain/models/category.dart';
import 'package:limen_app/domain/models/verse.dart';

class AppState extends ChangeNotifier {
  AppState(this._repository);

  final VerseRepository _repository;
  SharedPreferences? _prefs;

  final String _categoryKey = 'selected_category_ids';
  final String _verseIdKey = 'today_verse_id';
  final String _verseDateKey = 'today_verse_date';

  late final UnmodifiableListView<Category> _categories =
      UnmodifiableListView<Category>(_repository.categories);
  Set<String> _selectedCategoryIds = <String>{};
  Verse? _currentVerse;
  String? _storedDateKey;
  bool _initialized = false;

  UnmodifiableListView<Category> get categories => _categories;
  Set<String> get selectedCategoryIds => Set<String>.unmodifiable(_selectedCategoryIds);
  Verse? get currentVerse => _currentVerse;
  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    final List<String>? storedCategories = _prefs!.getStringList(_categoryKey);
    _selectedCategoryIds = storedCategories != null && storedCategories.isNotEmpty
        ? storedCategories.toSet()
        : _categories.map((Category c) => c.id).toSet();

    final String todayKey = _dateKey(DateTime.now());
    final String? storedVerseId = _prefs!.getString(_verseIdKey);
    final String? storedDate = _prefs!.getString(_verseDateKey);

    if (storedDate == todayKey && storedVerseId != null) {
      final Verse? verse = _repository.verseById(storedVerseId);
      if (verse != null && _selectedCategoryIds.contains(verse.categoryId)) {
        _currentVerse = verse;
        _storedDateKey = todayKey;
      }
    }

    if (_currentVerse == null) {
      await _selectNewVerseForDate(todayKey);
    }

    _initialized = true;
    notifyListeners();
  }

  Future<void> ensureVerseForToday() async {
    final String todayKey = _dateKey(DateTime.now());
    if (_storedDateKey == todayKey && _currentVerse != null) {
      return;
    }
    await _selectNewVerseForDate(todayKey);
    notifyListeners();
  }

  Future<void> updateSelectedCategories(Set<String> categoryIds) async {
    if (categoryIds.isEmpty) {
      throw ArgumentError('At least one category must be selected.');
    }
    _selectedCategoryIds = categoryIds;
    await _prefs?.setStringList(_categoryKey, categoryIds.toList());
    await _selectNewVerseForDate(_dateKey(DateTime.now()));
    notifyListeners();
  }

  Category? categoryById(String id) {
    try {
      return _categories.firstWhere((Category c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  bool isCategorySelected(String id) => _selectedCategoryIds.contains(id);

  Future<void> _selectNewVerseForDate(String dateKey) async {
    final Verse? verse = _repository.randomVerse(_selectedCategoryIds);
    _currentVerse = verse;
    _storedDateKey = dateKey;
    await _prefs?.setString(_verseDateKey, dateKey);
    if (verse == null) {
      await _prefs?.remove(_verseIdKey);
    } else {
      await _prefs?.setString(_verseIdKey, verse.id);
    }
  }

  String _dateKey(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState appState,
    required super.child,
  }) : super(notifier: appState);

  static AppState of(BuildContext context) {
    final AppStateScope? scope =
        context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found in widget tree');
    return scope!.notifier!;
  }
}
