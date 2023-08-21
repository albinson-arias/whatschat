import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  PreferencesRepository({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  static const String keyOnboardingCompleted = 'onboarding_completed';

  bool get onboardingCompleted =>
      sharedPreferences.getBool(keyOnboardingCompleted) ?? false;

  set onboardingCompleted(bool value) =>
      sharedPreferences.setBool(keyOnboardingCompleted, value);
}
