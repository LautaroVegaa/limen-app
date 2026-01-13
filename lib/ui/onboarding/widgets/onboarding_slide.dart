import 'package:flutter/material.dart';

import 'package:limen_app/theme/app_colors.dart';

/// Renders the large onboarding headline with a single accent highlight.
class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.headline,
    required this.highlight,
  });

  final String headline;
  final String highlight;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context).textTheme.displayLarge ??
        const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w600,
          height: 1.2,
          color: AppColors.textPrimary,
        );
    final TextStyle highlightStyle = baseStyle.copyWith(color: AppColors.accent);

    return Text.rich(
      _buildHeadlineSpan(baseStyle, highlightStyle),
      textAlign: TextAlign.left,
      softWrap: true,
    );
  }

  TextSpan _buildHeadlineSpan(TextStyle base, TextStyle accent) {
    final int highlightStart = headline.toLowerCase().indexOf(highlight.toLowerCase());

    if (highlightStart == -1) {
      return TextSpan(text: headline, style: base);
    }

    final String before = headline.substring(0, highlightStart);
    final String highlighted = headline.substring(
      highlightStart,
      highlightStart + highlight.length,
    );
    final String after = headline.substring(highlightStart + highlight.length);

    return TextSpan(
      children: [
        TextSpan(text: before, style: base),
        TextSpan(text: highlighted, style: accent),
        TextSpan(text: after, style: base),
      ],
    );
  }
}
