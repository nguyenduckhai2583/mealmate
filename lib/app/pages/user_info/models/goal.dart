import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';

enum Goal {
  weightLoss,
  muscleGain,
  diabetes,
  digestion,
  healthyAging,
  balancedNutrition,
  lowerCholesterol,
  healthPregnancy,
  vegan,
  skinHealth,
  reduceStress,
  boneHeath,
  sleepQuality;

  const Goal();

  String getTitle(BuildContext context) {
    return switch (this) {
      Goal.weightLoss => context.localization.weightLoss,
      Goal.muscleGain => context.localization.muscleGain,
      Goal.diabetes => context.localization.manageDiabetes,
      Goal.digestion => context.localization.digestion,
      Goal.healthyAging => context.localization.healthyAging,
      Goal.balancedNutrition => context.localization.balancedNutrition,
      Goal.lowerCholesterol => context.localization.lowerCholesterol,
      Goal.healthPregnancy => context.localization.healthPregnancy,
      Goal.vegan => context.localization.vegan,
      Goal.skinHealth => context.localization.skinHealth,
      Goal.reduceStress => context.localization.reduceStress,
      Goal.boneHeath => context.localization.boneHealth,
      Goal.sleepQuality => context.localization.sleepQuality,
    };
  }
}