class AppDefines {
  static const baseApi = "https://gemini.gpu.rdhasaki.com/api/";
  static const dateTimeFormat = 'dd/MM/yyyy - HH:mm';
  static const dateFormat = 'dd/MM/yyyy';

  static const Duration fileUploadTimeOutDef = Duration(
    milliseconds: 1000 * 60 * 2,
  );
}

extension AppKeys on AppDefines {
  static const isFirstLaunchAppKey = "is-first-launch-key";
  static const alreadyInitUserInfo = "init-user-key";
  static const userInfoBox = "user-info-box";
  static const userInfoKey = "user-info-key";
  static const mealResultBox = "meal-result-box";
  static const localeKey = "locale-key";
}

extension AppProperties on AppDefines {
  static const Duration defaultTransitionDuration = Duration(milliseconds: 250);
  static const double contentMargin = 16;
}