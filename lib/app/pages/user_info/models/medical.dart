import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

enum MedicalCondition {
  diabetes,
  hypertension,
  hearthDisease,
  highCholesterol,
  digestiveIssues,
  osteoporosis,
  kidneyDisease,
  obesity,
  anemia,
  depression,
  gout;

  const MedicalCondition();

  String getTitle(BuildContext context) {
    return switch (this) {
      MedicalCondition.diabetes => context.localization.diabetes,
      MedicalCondition.hypertension => context.localization.hypertension,
      MedicalCondition.hearthDisease => context.localization.hearthDisease,
      MedicalCondition.highCholesterol => context.localization.highCholesterol,
      MedicalCondition.digestiveIssues => context.localization.digestiveIssues,
      MedicalCondition.osteoporosis => context.localization.osteoporosis,
      MedicalCondition.kidneyDisease => context.localization.kidneyDisease,
      MedicalCondition.obesity => context.localization.obesity,
      MedicalCondition.anemia => context.localization.anemia,
      MedicalCondition.depression => context.localization.depression,
      MedicalCondition.gout => context.localization.gout,
    };
  }
}