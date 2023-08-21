import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:whatschat/src/common/widgets/app_button.dart';
import 'package:whatschat/src/features/onboarding/bloc/onboarding_page_cubit.dart';
import 'package:whatschat/src/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:whatschat/src/navigation/routes.dart';

import '../../../../../helpers/helpers.dart';
import '../../../../../helpers/mock_go_router_provider.dart';
import '../../../../../helpers/mocks.dart';

void main() {
  late OnboardingPageCubit cubit;
  late MockPreferencesRepository mockPreferencesRepository;
  late MockGoRouter mockGoRouter;

  setUp(() {
    mockPreferencesRepository = MockPreferencesRepository();
    cubit =
        OnboardingPageCubit(preferencesRepository: mockPreferencesRepository);
    mockGoRouter = MockGoRouter();
  });
  group('onboardingPage', () {
    testWidgets('renders correctly', (widgetTester) async {
      // Arrange
      final onboardingPage = BlocProvider(
        create: (context) => cubit,
        child: const OnboardingPage(),
      );

      // Act
      await widgetTester.pumpApp(onboardingPage);

      // Assert
      expect(find.byType(OnboardingPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.byType(AppButton), findsOneWidget);
    });

    testWidgets(
        'calls correct method and pops when get started button is pressed',
        (widgetTester) async {
      // Arrange
      final onboardingPage = BlocProvider(
        create: (context) => cubit,
        child: const OnboardingPage(),
      );

      when(() => mockGoRouter.pushReplacementNamed(Routes.home.name))
          .thenAnswer((_) async => null);

      // Act
      await widgetTester.pumpMockRouterApp(onboardingPage, mockGoRouter);
      await widgetTester.tap(find.byType(AppButton));
      await widgetTester.pumpAndSettle();

      // Assert
      verify(() => mockPreferencesRepository.onboardingCompleted = true)
          .called(1);

      verify(() => mockGoRouter.pushReplacementNamed(Routes.home.name))
          .called(1);
    });
  });
}
