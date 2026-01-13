import 'package:flutter/material.dart';

import 'package:limen_app/theme/app_colors.dart';

class ForwardArrowButton extends StatelessWidget {
  const ForwardArrowButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;

    return SizedBox(
      height: 60,
      width: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isEnabled
              ? AppColors.surface
              : AppColors.surface.withValues(alpha: 0.45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Icon(
          Icons.arrow_forward_rounded,
          size: 22,
          color: isEnabled
              ? AppColors.textPrimary
              : AppColors.textMuted.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
