import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:weight_app/helpers/routes.dart' as routes;
import 'package:weight_app/screens/home_screen.dart';
import 'package:weight_app/screens/result_info_screen.dart';
import 'package:weight_app/screens/result_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
    await DesktopWindow.setMinWindowSize(const Size(600, 700));
  }
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
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
        background: Container(color: Theme.of(context).canvasColor),
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


// See how u can make the bar persist or something idk
// Otherwise figure out how to fix it idk why it braking
