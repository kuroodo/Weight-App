import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weight_app/widgets/calc_form.dart';
import 'package:weight_app/widgets/navigation/nav_drawer.dart';
import 'package:weight_app/widgets/navigation/side_navigator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool useMobile = Platform.isAndroid || Platform.isIOS;
    return Scaffold(
      appBar: useMobile
          ? AppBar(title: const Text("Home"), centerTitle: true)
          : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!useMobile) const SideNavigator(),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: SingleChildScrollView(
                  child: CalcForm(),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: useMobile ? const NavDrawer() : null,
    );
  }
}
