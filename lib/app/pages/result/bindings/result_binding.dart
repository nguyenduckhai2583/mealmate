import 'package:mealmate/core.dart';

class ResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResultController());
  }
}