import 'package:flutter_test/flutter_test.dart';
import 'package:whatschat/src/features/onboarding/bloc/onboarding_page_states.dart';

void main() {
  group('OnboardingPageState', () {
    test('OnboardingPageInitial constructor', () {
      // Arrange - Act
      final state = OnboardingPageInitial();
      // Assert
      expect(state, isA<OnboardingPageState>());
      expect(state.props, <Object>[]);
    });
  });
}
