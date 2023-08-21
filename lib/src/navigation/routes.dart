import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatschat/src/features/home/presentation/pages/home_screen.dart';
import 'package:whatschat/src/features/onboarding/bloc/onboarding_page_cubit.dart';
import 'package:whatschat/src/features/onboarding/presentation/pages/onboarding_page.dart';

enum Routes { onboarding, home }

final routes = [
  GoRoute(
    path: '/onboarding',
    name: Routes.onboarding.name,
    builder: (_, __) => BlocProvider(
      create: (context) =>
          OnboardingPageCubit(preferencesRepository: context.read()),
      child: const OnboardingPage(),
    ),
  ),
  GoRoute(
    path: '/',
    name: Routes.home.name,
    builder: (_, __) => const HomePage(),
  ),
];
