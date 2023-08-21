import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatschat/src/features/onboarding/data/preferences_repository.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockPreferencesRepository extends Mock implements PreferencesRepository {}
