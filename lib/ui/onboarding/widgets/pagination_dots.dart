import 'package:flutter/material.dart';

import 'package:limen_app/theme/app_colors.dart';

class PaginationDots extends StatelessWidget {
  const PaginationDots({
    super.key,
    required this.itemCount,
    required this.activeIndex,
  });

  final int itemCount;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (int index) {
        final bool isActive = index == activeIndex;
        return Padding(
          padding: EdgeInsets.only(right: index == itemCount - 1 ? 0 : 8),
          child: Container(
            width: isActive ? 28 : 8,
            height: 4,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.textPrimary
                  : AppColors.textPrimary.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        );
      }),
    );
  }
}
