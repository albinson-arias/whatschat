import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatschat/bootstrap.dart';
import 'package:whatschat/src/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await bootstrap(
    () => RepositoryProvider<SharedPreferences>(
      create: (context) => prefs,
      child: const App(),
    ),
  );
}
