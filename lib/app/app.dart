import 'package:flutter/material.dart';
import 'package:test_work/pages/home_screen/home_screen.dart';
import 'package:test_work/pages/process_screen.dart';
import 'package:test_work/pages/result_screen.dart';

final _navigationKey = GlobalKey<NavigatorState>();

NavigatorState? get nav => _navigationKey.currentState;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      navigatorKey: _navigationKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => MediaQuery(
        data:
            MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)).copyWith(boldText: false),
        child: child!,
      ),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProcessScreen.routeName: (context) => const ProcessScreen(),
        ResultScreen.routeName: (context) => const ResultScreen(),
      },
    );
  }
}
