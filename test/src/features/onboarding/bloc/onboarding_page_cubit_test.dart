import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:whatschat/src/features/onboarding/bloc/onboarding_page_cubit.dart';
import 'package:whatschat/src/features/onboarding/bloc/onboarding_page_states.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late OnboardingPageCubit cubit;
  late MockPreferencesRepository preferencesRepository;

  setUp(() {
    preferencesRepository = MockPreferencesRepository();
    cubit = OnboardingPageCubit(preferencesRepository: preferencesRepository);
  });
  group('onboardingPageCubit', () {
    test('constructor', () {
      // Assert
      expect(cubit, isA<OnboardingPageCubit>());
      expect(cubit.preferencesRepository, preferencesRepository);
      expect(cubit.state, OnboardingPageInitial());
    });

    blocTest<OnboardingPageCubit, OnboardingPageState>(
      'emits [MyState] when onOnboardingCompleted() is called.',
      setUp: () {},
      build: () => cubit,
      act: (cubit) => cubit.onOnboardingCompleted(),
      expect: () => const <OnboardingPageState>[],
      verify: (_) async {
        verify(() => preferencesRepository.onboardingCompleted = true)
            .called(1);
      },
    );
  });
}
