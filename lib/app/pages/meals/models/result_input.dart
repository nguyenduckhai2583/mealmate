import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';
import 'package:hive/hive.dart';

part 'result_input.g.dart';

enum MealTime {
  breakfast,
  lunch,
  dinner;

  const MealTime();

  String getTitle(BuildContext context) {
    return switch (this) {
      MealTime.breakfast => context.localization.breakfast,
      MealTime.lunch => context.localization.lunch,
      MealTime.dinner => context.localization.dinner,
    };
  }

  IconData getIcon() {
    return switch (this) {
      MealTime.breakfast => Icons.free_breakfast_outlined,
      MealTime.lunch => Icons.restaurant_menu_outlined,
      MealTime.dinner => Icons.restaurant_outlined,
    };
  }
}

@HiveType(typeId: 4)
enum MealType {
  @HiveField(0)
  mealMatch,
  @HiveField(1)
  mealSuggestion,
  @HiveField(2)
  mealIngredient;

  const MealType();

  bool hasPhoto() =>
      this == MealType.mealMatch || this == MealType.mealIngredient;

  String getTitle(BuildContext context) {
    return switch (this) {
      MealType.mealMatch => context.localization.mealMatch,
      MealType.mealSuggestion => context.localization.mealSuggestion,
      MealType.mealIngredient => context.localization.mealFromIngredient,
    };
  }
}

class ResultInput {
  String? filePath;
  MealTime? mealTime;
  MealType? mealType;
  ResultResponse? result;

  ResultInput({this.filePath, this.mealTime, this.mealType, this.result});
}
