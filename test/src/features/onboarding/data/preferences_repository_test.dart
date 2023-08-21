import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:whatschat/src/features/onboarding/data/preferences_repository.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockSharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
  });
  group('Preferences Repository', () {
    test('Constructor', () {
      // Arrange - Act
      final repository = PreferencesRepository(
        sharedPreferences: sharedPreferences,
      );
      // Assert
      expect(repository, isA<PreferencesRepository>());
      expect(repository.sharedPreferences, sharedPreferences);
    });

    group('get onboardingCompleted', () {
      test('returns true when given true', () {
        // Arrange
        when(
          () => sharedPreferences.getBool(
            PreferencesRepository.keyOnboardingCompleted,
          ),
        ).thenReturn(true);
        final repository = PreferencesRepository(
          sharedPreferences: sharedPreferences,
        );

        // Act
        final value = repository.onboardingCompleted;

        // Assert
        expect(value, isTrue);
      });

      test('returns false when given false', () {
        // Arrange
        when(
          () => sharedPreferences.getBool(
            PreferencesRepository.keyOnboardingCompleted,
          ),
        ).thenReturn(false);
        final repository = PreferencesRepository(
          sharedPreferences: sharedPreferences,
        );

        // Act
        final value = repository.onboardingCompleted;

        // Assert
        expect(value, isFalse);
      });

      test('returns false when given null', () {
        // Arrange
        when(
          () => sharedPreferences.getBool(
            PreferencesRepository.keyOnboardingCompleted,
          ),
        ).thenReturn(null);
        final repository = PreferencesRepository(
          sharedPreferences: sharedPreferences,
        );

        // Act
        final value = repository.onboardingCompleted;

        // Assert
        expect(value, isFalse);
      });
    });

    group('set onboardingCompleted', () {
      test('correct call is being made when onBoardingCompleted is called', () {
        // Arrange
        when(
          () => sharedPreferences.setBool(
            PreferencesRepository.keyOnboardingCompleted,
            true,
          ),
        ).thenAnswer((_) async => true);
        final repository = PreferencesRepository(
          sharedPreferences: sharedPreferences,
        );

        // Act
        // ignore: cascade_invocations
        repository.onboardingCompleted = true;

        // Assert
        verify(
          () => sharedPreferences.setBool(
            PreferencesRepository.keyOnboardingCompleted,
            true,
          ),
        ).called(1);
      });
    });
  });
}
