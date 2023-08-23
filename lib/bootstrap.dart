import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:whatschat/src/core/colors.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // change the status bar color to material color [AppColors.background]
  await FlutterStatusbarcolor.setStatusBarColor(AppColors.background);
  if (useWhiteForeground(AppColors.background)) {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  } else {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }

  // change the navigation bar color to material color [AppColors.background]
  await FlutterStatusbarcolor.setNavigationBarColor(AppColors.background);

  await FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);

  runApp(await builder());
}
