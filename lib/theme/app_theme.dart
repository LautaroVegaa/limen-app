import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Provides the global visual foundation for the Limen app.
class AppTheme {
  static ThemeData build() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        onPrimary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          height: 1.15,
          letterSpacing: 0.2,
          color: AppColors.textPrimary,
          fontFamilyFallback: ['Georgia', 'Times New Roman', 'serif'],
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
