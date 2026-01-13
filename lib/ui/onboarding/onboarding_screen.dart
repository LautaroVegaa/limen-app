import 'package:flutter/material.dart';

import 'widgets/forward_arrow_button.dart';
import 'widgets/onboarding_slide.dart';
import 'widgets/pagination_dots.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  static final List<_OnboardingPageData> _pages = [
    _OnboardingPageData(
      headline: 'Your attention is being stolen by noise.',
      highlight: 'attention',
      background: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF040404),
          Color(0xFF1A1412),
        ],
      ),
    ),
    _OnboardingPageData(
      headline: 'Limen helps you pause before you scroll.',
      highlight: 'pause',
      background: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF060607),
          Color(0xFF16181B),
        ],
      ),
    ),
    _OnboardingPageData(
      headline: 'Choose intention over impulse.',
      highlight: 'intention',
      background: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF040404),
          Color(0xFF1C1413),
        ],
      ),
    ),
  ];

  void _goForward() {
    if (_currentIndex >= _pages.length - 1) return;
    setState(() => _currentIndex += 1);
  }

  @override
  Widget build(BuildContext context) {
    final _OnboardingPageData page = _pages[_currentIndex];

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: page.background),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaginationDots(
                  itemCount: _pages.length,
                  activeIndex: _currentIndex,
                ),
                const SizedBox(height: 64),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: OnboardingSlide(
                      headline: page.headline,
                      highlight: page.highlight,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ForwardArrowButton(
                    onPressed:
                        _currentIndex == _pages.length - 1 ? null : _goForward,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.headline,
    required this.highlight,
    required this.background,
  });

  final String headline;
  final String highlight;
  final Gradient background;
}
