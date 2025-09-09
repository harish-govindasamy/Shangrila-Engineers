import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shangrila/main.dart';

void main() {
  testWidgets('Renders Login Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the login screen is rendered.
    expect(find.text('Shangri-La'), findsOneWidget);
    expect(find.text('Project Management'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });
}
