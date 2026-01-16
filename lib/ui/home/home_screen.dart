import 'package:flutter/material.dart';

import 'package:limen_app/app/state/app_state.dart';
import 'package:limen_app/domain/models/verse.dart';
import 'package:limen_app/theme/app_colors.dart';
import 'package:limen_app/ui/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppState? _appState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppState state = AppStateScope.of(context);
    if (_appState != state) {
      _appState = state;
      state.ensureVerseForToday();
    }
  }

  Future<void> _openSettings() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppState state = AppStateScope.of(context);
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
            child: AnimatedBuilder(
              animation: state,
              builder: (BuildContext context, _) {
                final Verse? verse = state.currentVerse;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HomeTopBar(onSettingsTap: _openSettings),
                    const Spacer(),
                    if (verse == null)
                      const _EmptyState()
                    else
                      _VerseDisplay(
                        verse: verse,
                        categoryName: state.categoryById(verse.categoryId)?.name,
                      ),
                    const Spacer(flex: 2),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar({required this.onSettingsTap});

  final VoidCallback onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _AppIconPlaceholder(),
        _SettingsButton(onTap: onSettingsTap),
      ],
    );
  }
}

class _AppIconPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          'L',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface.withValues(alpha: 0.85),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.settings_rounded, size: 22, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.textMuted,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 76,
          width: 76,
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(38),
          ),
          child: Icon(
            Icons.auto_awesome_rounded,
            size: 36,
            color: AppColors.textPrimary.withValues(alpha: 0.25),
          ),
        ),
        const SizedBox(height: 24),
        Text('Your verses will appear here', style: textStyle, textAlign: TextAlign.center),
      ],
    );
  }
}

class _VerseDisplay extends StatelessWidget {
  const _VerseDisplay({required this.verse, this.categoryName});

  final Verse verse;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (categoryName != null) ...[
          Text(
            categoryName!,
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.accent.withValues(alpha: 0.8),
              letterSpacing: 0.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
        ],
        Text(
          verse.text,
          style: textTheme.displayLarge?.copyWith(
                fontSize: 30,
                height: 1.3,
                color: AppColors.textPrimary,
              ) ??
              const TextStyle(
                fontSize: 30,
                height: 1.3,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 18),
        Text(
          verse.reference,
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.textMuted,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
