import 'dart:math';

import 'package:limen_app/domain/data/verse_data.dart';
import 'package:limen_app/domain/models/category.dart';
import 'package:limen_app/domain/models/verse.dart';

class VerseRepository {
  VerseRepository({Random? random}) : _random = random ?? Random();

  final Random _random;

  List<Category> get categories => List<Category>.unmodifiable(kCategories);

  Verse? verseById(String id) {
    try {
      return kVerses.firstWhere((Verse verse) => verse.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Verse> versesForCategories(Set<String> categoryIds) {
    if (categoryIds.isEmpty) {
      return const [];
    }
    return kVerses
        .where((Verse verse) => categoryIds.contains(verse.categoryId))
        .toList(growable: false);
  }

  Verse? randomVerse(Set<String> categoryIds) {
    final List<Verse> pool = versesForCategories(categoryIds);
    if (pool.isEmpty) {
      return null;
    }
    final int index = _random.nextInt(pool.length);
    return pool[index];
  }
}
