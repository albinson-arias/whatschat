import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatschat/src/l10n/l10n.dart';
import 'package:whatschat/src/navigation/router.dart';

import 'mock_go_router_provider.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) async {
    await pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
      ),
    );
    await pumpAndSettle();
  }

  Future<void> pumpMockRouterApp(
    Widget widget,
    MockGoRouter mockGoRouter,
  ) async {
    await pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MockGoRouterProvider(mockGoRouter: mockGoRouter, child: widget),
      ),
    );
    await pumpAndSettle();
  }

  Future<void> pumpRealRouterApp(
    String? location,
    Widget Function(Widget child) builder,
  ) async {
    await pumpWidget(
      builder(
        MaterialApp.router(
          routerConfig: getRouter(location),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );

    await pumpAndSettle();
  }
}
