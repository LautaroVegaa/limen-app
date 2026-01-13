import 'package:flutter/material.dart';

import 'package:limen_app/theme/app_colors.dart';
import 'package:limen_app/ui/onboarding/models/hero_slide_data.dart';
import 'package:limen_app/ui/onboarding/models/onboarding_step.dart';
import 'package:limen_app/ui/onboarding/models/selectable_option.dart';
import 'package:limen_app/ui/onboarding/models/testimonial.dart';
import 'package:limen_app/ui/onboarding/widgets/age_picker.dart';
import 'package:limen_app/ui/onboarding/widgets/forward_arrow_button.dart';
import 'package:limen_app/ui/onboarding/widgets/onboarding_progress_bar.dart';
import 'package:limen_app/ui/onboarding/widgets/onboarding_slide.dart';
import 'package:limen_app/ui/onboarding/widgets/pagination_dots.dart';
import 'package:limen_app/ui/onboarding/widgets/primary_button.dart';
import 'package:limen_app/ui/onboarding/widgets/selectable_card.dart';
import 'package:limen_app/ui/onboarding/widgets/testimonial_card.dart';

class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key, this.onFinished});

  final VoidCallback? onFinished;

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen> {
  static const List<HeroSlideData> _heroSlides = [
    HeroSlideData(
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
    HeroSlideData(
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
    HeroSlideData(
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

  static const List<SelectableOption> _goalOptions = [
    SelectableOption(label: 'Spiritual Growth'),
    SelectableOption(label: 'Personal Development'),
    SelectableOption(label: 'Relational Goals'),
    SelectableOption(label: 'Health and Well-Being'),
    SelectableOption(label: 'Community and Service'),
  ];

  static const List<SelectableOption> _obstacleOptions = [
    SelectableOption(label: 'Social media'),
    SelectableOption(label: 'Lack of focus'),
    SelectableOption(label: 'Lack of motivation'),
    SelectableOption(label: 'Social depression'),
  ];

  static const List<Testimonial> _testimonials = [
    Testimonial(
      name: 'Fisher Roberts',
      timestamp: '24 mins ago',
      rating: 5,
      quote:
          'I just started this app and I already like it. It keeps me off social media so I can spend time with intention.',
    ),
    Testimonial(
      name: 'Eliseo Williamson',
      timestamp: '1 hour ago',
      rating: 5,
      quote:
          'It helps me pause before picking up my phone and reconnect with what matters most each morning.',
    ),
    Testimonial(
      name: 'Vada Clay',
      timestamp: '1 hour ago',
      rating: 5,
      quote:
          'Limen gently pushes me toward quiet space and deeper reflection before the noise of the feeds.',
    ),
    Testimonial(
      name: 'Bridger Morton',
      timestamp: '2 hours ago',
      rating: 5,
      quote:
          'A calm reminder to be present. The prompts keep me grounded and away from mindless scrolling.',
    ),
  ];

  late final List<OnboardingStep> _steps;
  final List<int> _ageOptions = List<int>.generate(63, (int index) => 18 + index);
  final FixedExtentScrollController _ageScrollController = FixedExtentScrollController();

  int _currentStepIndex = 0;
  int? _selectedAge;
  final Set<String> _selectedGoals = <String>{};
  final Set<String> _selectedObstacles = <String>{};

  @override
  void initState() {
    super.initState();
    _steps = [
      for (final HeroSlideData hero in _heroSlides) OnboardingStep.hero(hero),
      const OnboardingStep.age('How old are you?'),
      OnboardingStep.goals(
        headline: 'What is your goal this year?',
        options: _goalOptions,
      ),
      OnboardingStep.obstacles(
        headline: 'What stops you from reaching your goal?',
        options: _obstacleOptions,
      ),
      OnboardingStep.testimonials(
        headline: 'We’ve helped 100k+ people so far.',
        testimonials: _testimonials,
      ),
    ];
  }

  @override
  void dispose() {
    _ageScrollController.dispose();
    super.dispose();
  }

  bool get _isLastStep => _currentStepIndex == _steps.length - 1;

  bool get _canProceed {
    final OnboardingStep step = _steps[_currentStepIndex];
    switch (step.type) {
      case OnboardingStepType.hero:
        return true;
      case OnboardingStepType.age:
        return _selectedAge != null;
      case OnboardingStepType.goals:
        return _selectedGoals.isNotEmpty;
      case OnboardingStepType.obstacles:
        return _selectedObstacles.isNotEmpty;
      case OnboardingStepType.testimonials:
        return true;
    }
  }

  double get _progress => (_currentStepIndex + 1) / _steps.length;

  void _goToNextStep() {
    if (!_canProceed || _isLastStep) return;
    setState(() => _currentStepIndex += 1);
  }

  void _handleFinalCta() {
    if (_canProceed) {
      widget.onFinished?.call();
    }
  }

  void _onAgeSelected(int age) {
    setState(() => _selectedAge = age);
  }

  void _toggleGoal(String label) {
    setState(() {
      if (_selectedGoals.contains(label)) {
        _selectedGoals.remove(label);
      } else {
        _selectedGoals.add(label);
      }
    });
  }

  void _toggleObstacle(String label) {
    setState(() {
      if (_selectedObstacles.contains(label)) {
        _selectedObstacles.remove(label);
      } else {
        _selectedObstacles.add(label);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final OnboardingStep step = _steps[_currentStepIndex];
    final bool isHeroStep = step.type == OnboardingStepType.hero;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(gradient: _backgroundForStep(step)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnboardingProgressBar(progress: _progress),
                SizedBox(height: isHeroStep ? 24 : 32),
                Expanded(child: _buildStepContent(step)),
                if (!isHeroStep) ...[
                  const SizedBox(height: 32),
                  PrimaryButton(
                    label: step.type == OnboardingStepType.testimonials ? 'Continue' : 'Next',
                    onPressed: step.type == OnboardingStepType.testimonials
                        ? _handleFinalCta
                        : _goToNextStep,
                    enabled: _canProceed,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(OnboardingStep step) {
    switch (step.type) {
      case OnboardingStepType.hero:
        return _buildHeroStep(step.heroData!);
      case OnboardingStepType.age:
        return _buildAgeStep(step.headline!);
      case OnboardingStepType.goals:
        return _buildMultiSelectStep(
          headline: step.headline!,
          options: step.options!,
          selected: _selectedGoals,
          onToggle: _toggleGoal,
        );
      case OnboardingStepType.obstacles:
        return _buildMultiSelectStep(
          headline: step.headline!,
          options: step.options!,
          selected: _selectedObstacles,
          onToggle: _toggleObstacle,
        );
      case OnboardingStepType.testimonials:
        return _buildTestimonialsStep(step.headline!, step.testimonials!);
    }
  }

  Widget _buildHeroStep(HeroSlideData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaginationDots(
          itemCount: _heroSlides.length,
          activeIndex: _currentStepIndex,
        ),
        const SizedBox(height: 64),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: OnboardingSlide(
              headline: data.headline,
              highlight: data.highlight,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Align(
          alignment: Alignment.bottomRight,
          child: ForwardArrowButton(
            onPressed: _goToNextStep,
          ),
        ),
      ],
    );
  }

  Widget _buildAgeStep(String headline) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadline(headline),
        const SizedBox(height: 32),
        Expanded(
          child: Center(
            child: AgePicker(
              ages: _ageOptions,
              controller: _ageScrollController,
              onAgeSelected: _onAgeSelected,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultiSelectStep({
    required String headline,
    required List<SelectableOption> options,
    required Set<String> selected,
    required ValueChanged<String> onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadline(headline),
        const SizedBox(height: 32),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: options.length,
            separatorBuilder: (BuildContext context, int _) => const SizedBox(height: 16),
            itemBuilder: (BuildContext context, int index) {
              final SelectableOption option = options[index];
              return SelectableCard(
                label: option.label,
                selected: selected.contains(option.label),
                onTap: () => onToggle(option.label),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialsStep(String headline, List<Testimonial> testimonials) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadline(headline),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: testimonials.length,
            separatorBuilder: (BuildContext context, int _) => const SizedBox(height: 16),
            itemBuilder: (BuildContext context, int index) {
              return TestimonialCard(testimonial: testimonials[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeadline(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: AppColors.textPrimary,
          ),
    );
  }

  Gradient _backgroundForStep(OnboardingStep step) {
    if (step.heroData != null) {
      return step.heroData!.background;
    }
    return const LinearGradient(
      colors: [AppColors.background, AppColors.background],
    );
  }
}
