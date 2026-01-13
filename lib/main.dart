import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'ui/onboarding/screens/onboarding_flow_screen.dart';

void main() {
  runApp(const LimenApp());
}

class LimenApp extends StatelessWidget {
  const LimenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Limen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      home: const OnboardingFlowScreen(),
    );
  }
}

