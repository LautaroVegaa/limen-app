import 'package:flutter/material.dart';

import 'package:limen_app/theme/app_colors.dart';
import 'package:limen_app/ui/onboarding/models/testimonial.dart';

class TestimonialCard extends StatelessWidget {
  const TestimonialCard({super.key, required this.testimonial});

  final Testimonial testimonial;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    testimonial.timestamp,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                  ),
                ],
              ),
              _RatingDots(rating: testimonial.rating),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            testimonial.quote,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.35,
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}

class _RatingDots extends StatelessWidget {
  const _RatingDots({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (int index) {
        final bool filled = index < rating;
        return Padding(
          padding: EdgeInsets.only(left: index == 0 ? 0 : 4),
          child: Icon(
            Icons.star_rounded,
            color: filled ? AppColors.accent : AppColors.surface.withValues(alpha: 0.5),
            size: 18,
          ),
        );
      }),
    );
  }
}
