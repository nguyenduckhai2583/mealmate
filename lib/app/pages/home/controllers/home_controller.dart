import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class HomeController extends GetxController with HiveMixin {
  late int navigatorKey;

  final pages = <String>[Routes.meals, Routes.history, Routes.account];

  final RxInt _currentTabIdx = 0.obs;
  int get currentTabIdx => _currentTabIdx.value;
  set currentTabIdx(int value) => _currentTabIdx.value = value;

  @override
  void onInit() {
    navigatorKey = DateTime.now().millisecondsSinceEpoch;
    super.onInit();
  }

  Future<void> onChangeTab(int index) async {
    if (index != currentTabIdx) {
      currentTabIdx = index;
      Get.offNamed<void>(pages[index], id: navigatorKey);
    }
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.meals) {
      return GetPageRoute<dynamic>(
        settings: settings,
        page: () => const MealsView(),
        binding: MealsBinding(),
      );
    }
    if (settings.name == Routes.history) {
      return GetPageRoute<dynamic>(
        settings: settings,
        page: () => const HistoryView(),
        binding: HistoryBinding(),
        transition: Transition.fade,
      );
    }
    if (settings.name == Routes.account) {
      return GetPageRoute<dynamic>(
        settings: settings,
        page: () => const AccountView(),
        transition: Transition.fade,
      );
    }

    return null;
  }
}
