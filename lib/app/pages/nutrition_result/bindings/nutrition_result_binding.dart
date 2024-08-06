import 'package:mealmate/core.dart';

class NutritionResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NutritionResultController());
  }
}