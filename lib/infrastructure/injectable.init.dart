import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:test_work/infrastructure/injectable.init.config.dart';

@InjectableInit()
Future<void> configureDependencies(GetIt getIt) async => getIt.init();
