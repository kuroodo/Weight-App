import 'package:flutter/material.dart';
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
        "home_screen": (context) => const HomeScreen(),
        "result_screen": (context) => const ResultScreen(),
        "result_info_screen": (context) => const ResultInfoScreen(),
      },
      initialRoute: "home_screen",
    );
  }
}
