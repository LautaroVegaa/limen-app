// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:limen_app/main.dart';
import 'package:limen_app/ui/onboarding/screens/onboarding_flow_screen.dart';

void main() {
  testWidgets('renders first onboarding screen', (WidgetTester tester) async {
    await tester.pumpWidget(const LimenApp());

    expect(find.byType(OnboardingFlowScreen), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward_rounded), findsOneWidget);
    expect(find.textContaining('Your attention'), findsOneWidget);
  });
}
