import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:weight_app/helpers/navigation.dart';
import 'package:weight_app/providers/form_data_provider.dart';
import 'package:weight_app/widgets/navigation/footer.dart';

class SideNavigator extends ConsumerWidget {
  const SideNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool showTitle = !ResponsiveWrapper.of(context).isSmallerThan(DESKTOP);
    bool isResultsDisabled = ref.read(formDataProvider) == null;

    List<SideMenuItemDataTile> items = [
      buildDataTile(
        title: 'Home',
        onTap: Navigation.isHomeScreen
            ? () {}
            : () => Navigation.popAndNavigateTo(
                route: homeScreen, context: context),
        icon: Icons.home,
        isSelected: Navigation.currentRoute == homeScreen,
      ),
      buildDataTile(
        title: 'Results',
        onTap: isResultsDisabled
            ? () => ScaffoldMessenger.of(context).showSnackBar(buildErrorBar())
            : Navigation.isResultScreen
                ? () {}
                : () => Navigation.popAndNavigateTo(
                    route: resultScreen, context: context),
        icon: Icons.analytics_outlined,
        isSelected: Navigation.currentRoute == resultScreen,
        isDisabled: isResultsDisabled,
      ),
      buildDataTile(
        title: 'Weight Loss Tips',
        onTap: () {
          print("Test");
        },
        icon: Icons.tips_and_updates,
        isSelected: false,
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
        footer: const Footer(),
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
    bool isDisabled = false,
  }) {
    return SideMenuItemDataTile(
      isSelected: isSelected,
      onTap: onTap,
      title: title,
      icon: Icon(icon),
      highlightSelectedColor: Colors.grey.withOpacity(.6),
      hoverColor: Colors.grey.withOpacity(isDisabled ? 0 : .2),
      unSelectedColor: Colors.white.withOpacity(isDisabled ? .15 : .9),
      itemHeight: 50,
      margin: const EdgeInsetsDirectional.only(bottom: 5),
      hasSelectedLine: false,
    );
  }

  SnackBar buildErrorBar() {
    return const SnackBar(
      content: Text(
        "Please fill out the form first!",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.redAccent,
    );
  }
}
