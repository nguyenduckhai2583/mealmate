import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

enum Gender { male, female }

extension GenderExt on Gender {
  String getTitle(BuildContext context) {
    if (this == Gender.male) {
      return context.localization.male;
    } else {
      return context.localization.female;
    }
  }

  IconData getIcon() {
    if (this == Gender.male) {
      return Icons.male;
    } else {
      return Icons.female;
    }
  }
}