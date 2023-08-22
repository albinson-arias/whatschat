import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/l10n/generated/phone_field_localization.dart';
import 'package:whatschat/src/core/theme.dart';
import 'package:whatschat/src/features/onboarding/data/preferences_repository.dart';
import 'package:whatschat/src/l10n/l10n.dart';
import 'package:whatschat/src/navigation/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PreferencesRepository>(
      create: (context) => PreferencesRepository(
        sharedPreferences: context.read(),
      ),
      child: MaterialApp.router(
        routerConfig: getRouter(),
        theme: appTheme(),
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          PhoneFieldLocalization.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
