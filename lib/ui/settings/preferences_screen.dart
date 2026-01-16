import 'package:flutter/material.dart';

import 'package:limen_app/app/state/app_state.dart';
import 'package:limen_app/domain/models/category.dart';
import 'package:limen_app/theme/app_colors.dart';
import 'package:limen_app/ui/onboarding/widgets/primary_button.dart';
import 'package:limen_app/ui/onboarding/widgets/selectable_card.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  Set<String>? _tempSelection;
  bool _saving = false;

  AppState get _appState => AppStateScope.of(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tempSelection ??= _appState.selectedCategoryIds.toSet();
  }

  void _toggle(String id) {
    setState(() {
      if (_tempSelection!.contains(id)) {
        _tempSelection!.remove(id);
      } else {
        _tempSelection!.add(id);
      }
    });
  }

  Future<void> _save() async {
    if (_tempSelection == null || _tempSelection!.isEmpty) {
      return;
    }
    setState(() => _saving = true);
    await _appState.updateSelectedCategories(_tempSelection!.toSet());
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = _appState.categories;
    final bool canSave = (_tempSelection?.isNotEmpty ?? false) && !_saving;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF080808),
              Color(0xFF0D0D0F),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Preferences',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 32,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final Category category = categories[index];
                      final bool selected = _tempSelection?.contains(category.id) ?? false;
                      return SelectableCard(
                        label: category.name,
                        selected: selected,
                        onTap: () => _toggle(category.id),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 16),
                    itemCount: categories.length,
                  ),
                ),
                PrimaryButton(
                  label: _saving ? 'Saving…' : 'Save',
                  onPressed: _save,
                  enabled: canSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
