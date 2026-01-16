import 'package:flutter/material.dart';

import 'package:limen_app/theme/app_colors.dart';
import 'package:limen_app/ui/settings/preferences_screen.dart';
import 'package:limen_app/ui/settings/widgets/setting_tiles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF080808),
              Color(0xFF0D0D0F),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: AppColors.textPrimary, size: 22),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 16),
              _SettingsCard(
                children: [
                  ActionSettingTile(
                    icon: Icons.tune_rounded,
                    label: 'Verse Categories',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const PreferencesScreen(),
                        ),
                      );
                    },
                    showChevron: true,
                  ),
                  ActionSettingTile(
                    icon: Icons.mail_outline_rounded,
                    label: 'Contact Us',
                    onTap: () {},
                  ),
                  ActionSettingTile(
                    icon: Icons.ios_share_rounded,
                    label: 'Share Limen',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _SettingsCard(
                children: [
                  ActionSettingTile(
                    icon: Icons.description_outlined,
                    label: 'Terms & Services',
                    onTap: () {},
                    showChevron: true,
                  ),
                  ActionSettingTile(
                    icon: Icons.shield_moon_outlined,
                    label: 'Privacy Policy',
                    onTap: () {},
                    showChevron: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _SettingsCard(
                isInformational: true,
                children: const [
                  InfoSettingTile(label: 'Version', value: '1.0.0'),
                  InfoSettingTile(label: 'User Status', value: 'Free'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children, this.isInformational = false});

  final List<Widget> children;
  final bool isInformational;

  @override
  Widget build(BuildContext context) {
    final Color background = isInformational
        ? AppColors.surface.withValues(alpha: 0.45)
        : AppColors.surface.withValues(alpha: 0.7);

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: List<Widget>.generate(children.length * 2 - 1, (int index) {
          if (index.isEven) {
            return children[index ~/ 2];
          }
          return Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white.withValues(alpha: 0.05),
          );
        }),
      ),
    );
  }
}
