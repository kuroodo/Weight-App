import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:weight_app/helpers/routes.dart' as routes;

class SideNavigator extends StatelessWidget {
  const SideNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    bool showTitle = !ResponsiveWrapper.of(context).isSmallerThan(DESKTOP);
    List<SideMenuItemDataTile> items = [
      buildDataTile(
        title: 'Home',
        onTap: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(routes.homeScreen, (route) => false);
        },
        icon: Icons.home,
        isSelected: true,
      ),
      buildDataTile(
        title: 'Results',
        onTap: () {
          print("Results");
        },
        icon: Icons.analytics_outlined,
      ),
      buildDataTile(
        title: 'Weight Loss Tips',
        onTap: () {
          print("Test");
        },
        icon: Icons.tips_and_updates,
      ),
    ];

    return SideMenu(
      builder: (data) => SideMenuData(
        header: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: showTitle
              ? Text(
                  "Weight App",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .color!
                        .withOpacity(.85),
                  ),
                )
              : null,
        ),
        items: items,
        footer: const _Footer(),
      ),
      backgroundColor: Theme.of(context).cardColor.withAlpha(100),
      maxWidth: 200,
      minWidth: 75,
      hasResizer: false,
      hasResizerToggle: false,
    );
  }

  SideMenuItemDataTile buildDataTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return SideMenuItemDataTile(
      isSelected: isSelected,
      onTap: onTap,
      title: title,
      icon: Icon(icon),
      highlightSelectedColor: Colors.grey.withOpacity(.6),
      hoverColor: Colors.grey.withOpacity(.2),
      unSelectedColor: Colors.white.withOpacity(.9),
      itemHeight: 50,
      margin: const EdgeInsetsDirectional.only(bottom: 5),
      hasSelectedLine: false,
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        color: Theme.of(context).textTheme.titleLarge!.color!.withOpacity(.75));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Weight App",
          style: style,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            "https://github.com/kuroodo/Weight-App",
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            "MIT License",
            style: style,
          ),
        ),
      ],
    );
  }
}
