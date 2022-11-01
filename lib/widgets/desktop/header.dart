import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const Header({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.menu),
      label: Text(label),
    );
  }
}
