import 'package:flutter/material.dart';

import 'app/state/app_state.dart';
import 'domain/data/verse_repository.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';
import 'ui/home/home_screen.dart';
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
      home: const _AppRoot(),
    );
  }
}

class _AppRoot extends StatefulWidget {
  const _AppRoot();

  @override
  State<_AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<_AppRoot> {
  bool _completedOnboarding = false;
  late final AppState _appState = AppState(VerseRepository());
  late final Future<void> _initialization = _appState.initialize();

  void _handleOnboardingFinished() {
    setState(() => _completedOnboarding = true);
    _appState.ensureVerseForToday();
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _AppLoadingScreen();
        }
        return AppStateScope(
          appState: _appState,
          child: _completedOnboarding
              ? const HomeScreen()
              : OnboardingFlowScreen(onFinished: _handleOnboardingFinished),
        );
      },
    );
  }
}

class _AppLoadingScreen extends StatelessWidget {
  const _AppLoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

