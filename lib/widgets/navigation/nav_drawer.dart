import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_app/helpers/navigation.dart';
import 'package:weight_app/providers/form_data_provider.dart';

class NavDrawer extends ConsumerWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isResultsDisabled = ref.read(formDataProvider) == null;
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
            isSelected: Navigation.isHomeScreen,
            onPressed: Navigation.isHomeScreen
                ? null
                : () => Navigation.popAndNavigateTo(
                    route: homeScreen, context: context),
          ),
          _NavButton(
            icon: Icons.analytics_outlined,
            text: "Results",
            isSelected: Navigation.isResultScreen,
            onPressed: isResultsDisabled
                ? null
                : Navigation.isResultScreen
                    ? null
                    : () => Navigation.popAndNavigateTo(
                        route: resultScreen, context: context),
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
  final bool isSelected;
  final VoidCallback? onPressed;
  const _NavButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? Colors.grey.withOpacity(.6) : null,
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
