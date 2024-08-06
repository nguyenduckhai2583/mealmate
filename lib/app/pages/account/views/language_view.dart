import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  bool navigateBack = false;

  @override
  void initState() {
    _initRoute();
    super.initState();
  }

  void _languageOnChanged(String languageCode) {
    LocalizationService.changeLocale(languageCode);
  }

  void _nextOnClicked() {
    if (navigateBack) {
      Get.back();
    } else {
      Get.toNamed(Routes.mbi);
    }
  }

  void _initRoute() {
    if (Get.arguments != null && Get.arguments is UserInfoInput) {
      navigateBack = (Get.arguments as UserInfoInput).navigateBack;
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentLocal = LocalizationService.getLocale();

    return Scaffold(
      appBar: AppBar(title: Text(context.localization.language)),
      floatingActionButton: Fab(onClick: _nextOnClicked),
      body: DefaultPadding(
        child: ListView.separated(
          itemCount: AppLocalizations.supportedLocales.length,
          separatorBuilder: (context, _) {
            return const Space();
          },
          itemBuilder: (context, index) {
            var locale = AppLocalizations.supportedLocales[index];
            var languageName = LocalizationService.getLanguageName(locale);
            return Card(
              child: InkWell(
                onTap: () => _languageOnChanged(locale.languageCode),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          languageName,
                          style: context.textTheme.titleSmall,
                        ),
                      ),
                      Radio(
                        value: locale,
                        groupValue: currentLocal,
                        onChanged: (val) {},
                        visualDensity: VisualDensity.compact,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
