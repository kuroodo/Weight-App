import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:weight_app/widgets/calc_form.dart';
import 'package:weight_app/widgets/desktop/header.dart';
import 'package:weight_app/widgets/nav_drawer.dart';

const _title = "Home";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool useMobile = ResponsiveWrapper.of(context).isSmallerThan(DESKTOP);
    return Scaffold(
      appBar: useMobile
          ? AppBar(title: const Text(_title), centerTitle: true)
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: useMobile ? const MobileHome() : const DesktopHome(),
        ),
      ),
      drawer: useMobile ? const NavDrawer() : null,
    );
  }
}

class MobileHome extends StatelessWidget {
  const MobileHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: CalcForm(),
      ),
    );
  }
}

class DesktopHome extends StatelessWidget {
  const DesktopHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            label: _title,
            onPressed: () {},
          ),
          const SizedBox(height: 50),
          const CalcForm(),
        ],
      ),
    );
  }
}
