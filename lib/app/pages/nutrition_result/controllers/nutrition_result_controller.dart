import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class NutritionResultController extends GetxController {
  PageController? pageController;
  RxInt currentNutritionIndex = 0.obs;

  late MealRemoteHttp mealRemoteHttp;
  String? filePath;

  final RxList<NutritionResponse> _nutritions = <NutritionResponse>[].obs;
  List<NutritionResponse> get nutritions => _nutritions;
  set nutritions(List<NutritionResponse> value) => _nutritions.value = value;

  RxBool loading = true.obs;

  @override
  void onInit() {
    mealRemoteHttp = Get.find<MealRemoteHttp>();

    if (Get.arguments != null && Get.arguments is ResultInput) {
      var input = Get.arguments as ResultInput;
      filePath = input.filePath;
      _getNutrition(filePath);
    }
    super.onInit();
  }

  void _getNutrition(String? path) async {
    if (path == null) return;

    var locale = LocalizationService.getLocale();
    var input = NutritionInput(path: path, locale: locale.languageCode);

    var result = await mealRemoteHttp.getNutritionInfo(input);
    if (result.isHaveRespData()) {
      nutritions = result.data!;

      if (nutritions.isNotEmpty) {
        pageController = PageController();
      }
    }

    loading.value = false;
  }

  void onPageChanged(int index) {
    currentNutritionIndex.value = index;
  }
}