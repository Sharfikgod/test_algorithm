import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_work/app/app.dart';
import 'package:test_work/infrastructure/injectable.init.dart';

final injector = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final getIt = GetIt.instance;
  await configureDependencies(getIt);

  runApp(const App());
}
