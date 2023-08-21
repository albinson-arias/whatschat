import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatschat/src/core/colors.dart';

void main() {
  group('AppColors', () {
    test('secondaryText', () {
      // Arrange
      final expectedColor = Colors.black.withOpacity(0.65);
      // Act
      final realColor = AppColors.secondaryText;
      // Assert
      expect(realColor, expectedColor);
    });
  });
}
