import 'package:flutter/material.dart';
import 'package:weight_app/widgets/calc_form.dart';
import 'package:weight_app/widgets/nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), centerTitle: true),
      body: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(child: CalcForm()),
          ),
        ),
      ),
      drawer: const NavDrawer(),
    );
  }
}
