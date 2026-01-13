import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:limen_app/theme/app_colors.dart';

class AgePicker extends StatelessWidget {
  const AgePicker({
    super.key,
    required this.ages,
    required this.controller,
    required this.onAgeSelected,
  });

  final List<int> ages;
  final FixedExtentScrollController controller;
  final ValueChanged<int> onAgeSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CupertinoPicker(
        scrollController: controller,
        itemExtent: 48,
        magnification: 1.05,
        squeeze: 1.2,
        useMagnifier: true,
        backgroundColor: Colors.transparent,
        onSelectedItemChanged: (int index) => onAgeSelected(ages[index]),
        children: ages
            .map(
              (int age) => Center(
                child: Text(
                  '$age years',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
