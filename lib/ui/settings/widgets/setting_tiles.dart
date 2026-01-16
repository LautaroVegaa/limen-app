import 'package:flutter/material.dart';

import 'package:limen_app/theme/app_colors.dart';

class ActionSettingTile extends StatelessWidget {
  const ActionSettingTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.showChevron = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onTap != null;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Row(
          children: [
            Icon(
              icon,
              color: enabled
                  ? AppColors.accent.withValues(alpha: 0.9)
                  : AppColors.textMuted.withValues(alpha: 0.4),
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            if (showChevron)
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted.withValues(alpha: 0.7),
              ),
          ],
        ),
      ),
    );
  }
}

class InfoSettingTile extends StatelessWidget {
  const InfoSettingTile({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.textMuted,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            value,
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
