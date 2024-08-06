import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(controller.navigatorKey),
        initialRoute: Routes.meals,
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Obx(
      () => NavigationBar(
        selectedIndex: controller.currentTabIdx,
        onDestinationSelected: controller.onChangeTab,
        destinations: [
          _buildBottomBarItem(
            context.localization.meals,
            const Icon(Icons.cookie_outlined),
          ),
          _buildBottomBarItem(
            context.localization.history,
            const Icon(Icons.history),
          ),
          _buildBottomBarItem(
            context.localization.account,
            const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }

  NavigationDestination _buildBottomBarItem(String title, Widget icon) {
    return NavigationDestination(label: title, icon: icon);
  }
}
