import 'dart:async';
import 'package:mealmate/core.dart';

class InitialController extends GetxController with StorageMixin {
  @override
  void onInit() {
    _appInitializer();
    super.onInit();
  }

  Future<void> _appInitializer() async {
    String apiEndpoint = AppDefines.baseApi;
    Uri? apiUri = Uri.tryParse(apiEndpoint);
    if (apiUri != null) {
      DioHelper.updateBaseUrl(DioHelper.currentDio(), apiUri);
    }

    await Future.delayed(const Duration(milliseconds: 2000));

    bool firstLaunch = box.getBool(
      AppKeys.isFirstLaunchAppKey,
      defaultVal: true,
    );
    bool initUser = box.getBool(
      AppKeys.alreadyInitUserInfo,
      defaultVal: false,
    );
    if (firstLaunch) {
      await Get.offNamed(Routes.onboarding);
    } else if (!initUser){
      await Get.offNamed(Routes.mbi);
    } else {
      await Get.offNamed(Routes.home);
    }
  }
}
