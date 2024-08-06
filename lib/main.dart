import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  String dir = (await getApplicationDocumentsDirectory()).path;
  String path = "$dir/mealmate";
  Hive
    ..init(path)
    ..registerAdapter(UserInfoAdapter())
    ..registerAdapter(ResultResponseAdapter())
    ..registerAdapter(DishAdapter())
    ..registerAdapter(MealTypeAdapter());
  runApp(DevicePreview(builder: (context) => const MyApp(), enabled: false));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _setPortrait() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }

  @override
  Widget build(BuildContext context) {
    _setPortrait();
    var currentLocale = LocalizationService.getLocale();

    return DismissKeyboard(
      child: GetMaterialApp(
        title: "MealMate",
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: currentLocale,
        themeMode: ThemeMode.system,
        theme: appLightTheme,
        darkTheme: appDarkTheme,
        defaultTransition: Transition.cupertino,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        initialBinding: InitialBinding(),
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}
