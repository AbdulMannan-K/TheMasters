import 'package:flutter/material.dart';
import 'package:the_masters/src/modules/home_page.dart';

class App extends StatelessWidget {
  static Future<void> initializeAndRun() async {
    return runApp(const App._());
  }

  const App._();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeView(),
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: InkSparkle.splashFactory,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(
            letterSpacing: .5,
            fontFamily: 'google-sans',
            fontWeight: FontWeight.bold,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: const TextStyle(
            letterSpacing: 1,
            fontFamily: 'google-sans',
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: Colors.grey.shade700,
          unselectedLabelStyle: const TextStyle(fontFamily: 'google-sans'),
        ),
        navigationRailTheme: const NavigationRailThemeData(
          unselectedLabelTextStyle: TextStyle(fontFamily: 'google-sans'),
        ),
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontFamily: 'google-sans'),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
