import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mealmate/core.dart';

part 'user_info.g.dart';

@HiveType(typeId: 1)
class UserInfo {
  @HiveField(0)
  String? gender;
  @HiveField(1)
  int? height;
  @HiveField(2)
  String? goal;
  @HiveField(3)
  List<String>? goalEnums;
  @HiveField(4)
  String? medicalCondition;
  @HiveField(5)
  List<String>? medicalConditionEnums;
  @HiveField(6)
  int? weight;
  @HiveField(7)
  int? age;

  UserInfo({
    this.gender,
    this.height,
    this.goal,
    this.goalEnums,
    this.medicalCondition,
    this.medicalConditionEnums,
    this.weight,
    this.age,
  });

  Map<String, dynamic> toRequest(BuildContext context) {
    /// goal
    String goalRq = getFullGoal(context);

    /// medical condition
    String mcRq = getFullMedicalCondition(context);

    /// height
    int? hRq;
    if (height != null) {
      hRq = height;
    }

    return {
      "height": hRq,
      "medical_history": mcRq,
      "goal": goalRq,
      "age": age,
      "weight": weight
    };
  }

  /// Gender
  Gender? getGender() {
    if (gender == null) return null;

    bool valid = Gender.values.any((element) => element.name == gender);
    if (valid) {
      return Gender.values.byName(gender!);
    }

    return null;
  }

  void setGender(Gender? gd) {
    gender = gd?.name;
  }

  /// Height
  int? getHeight() => height;

  void setHeight(int? h) => height = h;

  /// Goal
  List<Goal> getGoalChoices() {
    if (goalEnums == null) return [];
    List<Goal> data = [];

    goalEnums?.forEach((e) {
      var item = Goal.values.firstWhereOrNull((element) => element.name == e);
      if (item != null) {
        data.add(item);
      }
    });

    return data;
  }

  void setGoalChoices(List<Goal> goal) {
    goalEnums = goal.map((e) => e.name).toList();
  }

  void clearGoalChoices() {
    goalEnums?.clear();
  }

  String? getGoalText() => goal;

  void setGoalText(String t) => goal = t;

  void clearGoalText() {
    goal = "";
  }

  String getFullGoal(BuildContext context) {
    List<String> data = [];

    goalEnums?.forEach((e) {
      var item = Goal.values.firstWhereOrNull((element) => element.name == e);
      if (item != null) {
        data.add(item.getTitle(context));
      }
    });

    String goalRq = "";
    goalRq = data.join(", ");
    if (goal.hasCharacter) {
      goalRq += " and $goal";
    }

    return goalRq.trim();
  }

  /// Medical condition
  List<MedicalCondition> getMCChoices() {
    if (medicalConditionEnums == null) return [];
    List<MedicalCondition> data = [];

    medicalConditionEnums?.forEach((e) {
      var item = MedicalCondition.values.firstWhereOrNull(
        (element) => element.name == e,
      );
      if (item != null) {
        data.add(item);
      }
    });

    return data;
  }

  void setMCChoices(List<MedicalCondition> mc) {
    medicalConditionEnums = mc.map((e) => e.name).toList();
  }

  void clearMCChoices() {
    medicalConditionEnums?.clear();
  }

  String? getMCText() => medicalCondition;

  void setMCText(String t) => medicalCondition = t;

  void clearMCText() {
    medicalCondition = "";
  }

  String getFullMedicalCondition(BuildContext context) {
    String mcRq = "None";
    if (medicalConditionEnums != null && medicalConditionEnums!.isNotEmpty) {
      List<String> data = [];

      medicalConditionEnums?.forEach((e) {
        var item = MedicalCondition.values.firstWhereOrNull(
          (element) => element.name == e,
        );
        if (item != null) {
          data.add(item.getTitle(context));
        }
      });

      mcRq = data.join(", ");
    }

    if (medicalCondition.hasCharacter) {
      mcRq += ", $medicalCondition";
    }

    return mcRq.trim();
  }

  /// Weight
  int? getWeight() => weight;

  void setWeight(int? h) => weight = h;

  /// Age
  int? getAge() => age;

  void setAge(int? h) => age = h;
}
