import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:whatschat/src/features/home/presentation/pages/home_screen.dart';
import 'package:whatschat/src/features/onboarding/data/preferences_repository.dart';
import 'package:whatschat/src/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:whatschat/src/navigation/router.dart';

import '../../helpers/helpers.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockPreferencesRepository mockPreferencesRepository;

  setUp(() {
    mockPreferencesRepository = MockPreferencesRepository();
  });

  group('router', () {
    test('returns GoRouter', () {
      // Arrange - Act
      final router = getRouter();

      // Assert
      expect(router, isA<GoRouter>());
    });

    group('redirect', () {
      testWidgets(
        'when given onboardingComplete false render OnboardingPage',
        (widgetTester) async {
          // Arrange
          when(() => mockPreferencesRepository.onboardingCompleted)
              .thenReturn(false);

          // Act
          await widgetTester.pumpRealRouterApp(
            null,
            (child) => RepositoryProvider<PreferencesRepository>(
              create: (context) => mockPreferencesRepository,
              child: child,
            ),
          );

          // Assert
          expect(find.byType(OnboardingPage), findsOneWidget);
        },
      );
      testWidgets(
        'when given onboardingComplete true render HomePage',
        (widgetTester) async {
          // Arrange
          when(() => mockPreferencesRepository.onboardingCompleted)
              .thenReturn(true);

          // Act
          await widgetTester.pumpRealRouterApp(
            null,
            (child) => RepositoryProvider<PreferencesRepository>(
              create: (context) => mockPreferencesRepository,
              child: child,
            ),
          );

          // Assert
          expect(find.byType(HomePage), findsOneWidget);
        },
      );
    });
  });
}
