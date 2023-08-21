import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatschat/src/features/onboarding/bloc/onboarding_page_states.dart';
import 'package:whatschat/src/features/onboarding/data/preferences_repository.dart';

class OnboardingPageCubit extends Cubit<OnboardingPageState> {
  OnboardingPageCubit({required this.preferencesRepository})
      : super(OnboardingPageInitial());

  final PreferencesRepository preferencesRepository;

  void onOnboardingCompleted() {
    preferencesRepository.onboardingCompleted = true;
  }
}
