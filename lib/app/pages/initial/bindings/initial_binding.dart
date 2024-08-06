import 'package:mealmate/core.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetStorageBox());
    Get.put(InitialController());
  }
}
