import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class SideNavigator extends StatefulWidget {
  const SideNavigator({super.key});

  @override
  State<SideNavigator> createState() => _SideNavigatorState();
}

class _SideNavigatorState extends State<SideNavigator> {
  final SideMenuController page = SideMenuController();

  late final List<SideMenuItem> items;
  @override
  void initState() {
    super.initState();

    items = [
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 0,
        title: 'Home',
        onTap: (index, _) {
          print("Home");
          page.changePage(index);
        },
        icon: const Icon(Icons.home),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Results',
        onTap: (index, _) {
          print("Results");
          page.changePage(index);
        },
        icon: const Icon(Icons.analytics_outlined),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Weight Loss Tips',
        onTap: (index, _) {
          print("Test");
          page.changePage(index);
        },
        icon: const Icon(Icons.tips_and_updates),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      items: items,
      controller: page,
      collapseWidth: 800,
      displayModeToggleDuration: const Duration(milliseconds: 200),
      footer: const Padding(padding: EdgeInsets.all(8.0), child: _Footer()),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          "Weight App",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color:
                Theme.of(context).textTheme.titleLarge!.color!.withOpacity(.85),
          ),
        ),
      ),
      style: SideMenuStyle(
        openSideMenuWidth: 200,
        itemHeight: 60,
        itemOuterPadding: const EdgeInsets.symmetric(vertical: 5),
        hoverColor: Colors.grey.withOpacity(.2),
        selectedColor: Colors.grey.withOpacity(.6),
        selectedTitleTextStyle: const TextStyle(color: Colors.white),
        selectedIconColor: Colors.white,
        unselectedIconColor: Colors.white70,
        unselectedTitleTextStyle: const TextStyle(color: Colors.white70),
        backgroundColor: Theme.of(context).cardColor.withAlpha(100),
      ),
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
