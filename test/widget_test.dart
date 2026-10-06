import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webspark_test_task/app/app.dart';

void main() {
  testWidgets('Validates URL and preserves query parameters', (tester) async {
    await tester.pumpWidget(const WebSparkTest());
    expect(find.text('Home Screen'), findsOneWidget);

    for (final value in ['', 'example.com', 'ftp://example.com', 'https://']) {
      await tester.enterText(find.byType(TextField), value);
      await tester.tap(find.text('Start'));
      await tester.pump();
      expect(find.text('Invalid URL'), findsOneWidget);
    }

    const url = 'https://example.com/tasks?count=3&name=test';
    await tester.enterText(find.byType(TextField), '  $url  ');
    await tester.tap(find.text('Start'));
    await tester.pump();
    expect(find.text('Invalid URL'), findsNothing);
    expect(tester.widget<TextField>(find.byType(TextField)).controller!.text, url);
  });
}
