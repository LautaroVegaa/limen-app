import 'hero_slide_data.dart';
import 'selectable_option.dart';
import 'testimonial.dart';

enum OnboardingStepType {
  hero,
  age,
  goals,
  obstacles,
  testimonials,
}

class OnboardingStep {
  const OnboardingStep.hero(this.heroData)
      : type = OnboardingStepType.hero,
        headline = null,
        options = null,
        testimonials = null;

  const OnboardingStep.age(this.headline)
      : type = OnboardingStepType.age,
        heroData = null,
        options = null,
        testimonials = null;

  const OnboardingStep.goals({required this.headline, required this.options})
      : type = OnboardingStepType.goals,
        heroData = null,
        testimonials = null;

  const OnboardingStep.obstacles({required this.headline, required this.options})
      : type = OnboardingStepType.obstacles,
        heroData = null,
        testimonials = null;

  const OnboardingStep.testimonials({required this.headline, required this.testimonials})
      : type = OnboardingStepType.testimonials,
        heroData = null,
        options = null;

  final OnboardingStepType type;
  final HeroSlideData? heroData;
  final String? headline;
  final List<SelectableOption>? options;
  final List<Testimonial>? testimonials;
}
