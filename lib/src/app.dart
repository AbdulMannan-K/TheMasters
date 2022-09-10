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
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
