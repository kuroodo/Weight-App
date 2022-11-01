import 'package:flutter/material.dart';
import 'package:weight_app/helpers/routes.dart' as routes;

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.black, fontSize: 28),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(routes.homeScreen, (route) => false),
            icon: const Icon(Icons.home),
            label: const Text(
              "Home",
              style: TextStyle(color: Colors.lightBlue, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
