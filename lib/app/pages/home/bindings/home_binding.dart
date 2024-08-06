import 'package:mealmate/core.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MealRemoteHttp());
    Get.put(HomeController());

    Get.put(AccountController());
  }
}
