import 'package:flutter/material.dart';
import 'package:weight_app/helpers/routes.dart' as routes;
import 'package:weight_app/screens/home_screen.dart';
import 'package:weight_app/screens/result_info_screen.dart';
import 'package:weight_app/screens/result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      routes: {
        routes.homeScreen: (context) => const HomeScreen(),
        routes.resultScreen: (context) => const ResultScreen(),
        routes.resultInfoScreen: (context) => const ResultInfoScreen(),
      },
      initialRoute: routes.homeScreen,
    );
  }
}
