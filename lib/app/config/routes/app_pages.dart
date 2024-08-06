import 'package:mealmate/app/pages/account/views/language_view.dart';
import 'package:mealmate/app/pages/user_info/views/medical_condition_view.dart';
import 'package:mealmate/core.dart';

class AppPages {
  static const initial = Routes.initial;
  static final routes = [
    GetPage<dynamic>(
      name: Routes.initial,
      page: () => const InitialView(),
      binding: InitialBinding(),
      transition: Transition.zoom,
    ),
    GetPage<dynamic>(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
    ),
    GetPage<dynamic>(
      name: Routes.mbi,
      page: () => const MBIView(),
    ),
    GetPage<dynamic>(
      name: Routes.height,
      page: () => const HeightView(),
    ),
    GetPage<dynamic>(
      name: Routes.medicalCondition,
      page: () => const MedicalConditionView(),
    ),
    GetPage<dynamic>(
      name: Routes.goal,
      page: () => const GoalView(),
    ),
    GetPage<dynamic>(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.result,
      page: () => const ResultView(),
      binding: ResultBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.language,
      page: () => const LanguageView(),
    ),
    GetPage<dynamic>(
      name: Routes.nutritionResult,
      page: () => const NutritionResultView(),
      binding: NutritionResultBinding(),
    ),
  ];
}