import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mealmate/core.dart';

class LocalizationService {
  static Locale getLocale() {
    var current = GetStorage().read<String?>(AppKeys.localeKey);
    if (current == null) {
      return AppLocalizations.supportedLocales.first;
    }

    var locale = AppLocalizations.supportedLocales.firstWhereOrNull(
      (element) => element.languageCode == current,
    );

    return locale ?? AppLocalizations.supportedLocales.first;
  }

  static String getLanguageName(Locale locale) {
    return languages[locale.languageCode];
  }

  static final languages = Map.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
    'fr': "French",
    'pt': "Portuguese",
    'ja': "Japanese",
    'es': "Spanish",
  });

  static void changeLocale(String langCode) {
    var locale = AppLocalizations.supportedLocales.firstWhereOrNull(
      (element) => element.languageCode == langCode,
    );
    if (locale != null) {
      GetStorage().write(AppKeys.localeKey, locale.languageCode);
      Get.updateLocale(locale);
    }
  }
}
