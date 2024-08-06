import 'package:mealmate/core.dart';

class MealsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MealsController());
  }
}
