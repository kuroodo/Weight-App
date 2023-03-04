import 'package:flutter/material.dart';
import 'package:weight_app/helpers/navigation.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      backgroundColor: const Color.fromARGB(255, 55, 55, 55),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: Divider.createBorderSide(context,
                      color: Colors.transparent, width: 0),
                ),
              ),
              child: Text(
                'Weight App',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .color!
                      .withOpacity(.85),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          _NavButton(
            icon: Icons.home,
            text: "Home",
            onPressed: () => Navigation.popAndNavigateTo(
                route: homeScreen, context: context),
          ),
          _NavButton(
            icon: Icons.analytics_outlined,
            text: "Results",
            onPressed: () => print("Results"),
          ),
          _NavButton(
            icon: Icons.tips_and_updates,
            text: "Weight Toss Tips",
            onPressed: () => print("Results"),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  const _NavButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 6),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .color!
                  .withOpacity(.75),
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .color!
                    .withOpacity(.75),
                fontSize: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
