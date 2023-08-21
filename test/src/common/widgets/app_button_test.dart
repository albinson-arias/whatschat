import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatschat/src/common/widgets/app_button.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('AppButton', () {
    testWidgets('renders correctly', (widgetTester) async {
      // Arrange
      final widget = AppButton(
        onPressed: () {},
        text: 'Test',
      );
      // Act
      await widgetTester.pumpApp(widget);
      // Assert
      expect(find.text('Test'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('calls onPressed when pressed', (widgetTester) async {
      // Arrange
      var pressed = false;
      final widget = AppButton(
        onPressed: () => pressed = true,
        text: 'Test',
      );
      // Act
      await widgetTester.pumpApp(widget);
      await widgetTester.tap(find.byType(ElevatedButton));
      // Assert
      expect(pressed, isTrue);
    });
  });
}
