import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatschat/src/features/onboarding/data/preferences_repository.dart';
import 'package:whatschat/src/navigation/routes.dart';

GoRouter getRouter([String? initialLocation]) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation ?? '/onboarding',
    routes: routes,
    redirect: (context, state) {
      if (state.matchedLocation == '/onboarding') {
        if (context.read<PreferencesRepository>().onboardingCompleted) {
          return '/';
        }
      }
      return null;
    },
  );
}
