import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

extension ContextExtention on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  Color get primaryColor => theme.primaryColor;

  AppLocalizations get localization => AppLocalizations.of(this)!;
}