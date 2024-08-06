import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'result_response.g.dart';

@HiveType(typeId: 2)
class ResultResponse {
  @HiveField(0)
  String id;
  @HiveField(3)
  List<Dish>? dish;
  @HiveField(4)
  String? explain;
  @HiveField(5)
  DateTime? createDate;
  @HiveField(6)
  String? path;
  @HiveField(7)
  bool? alreadyAte;
  @HiveField(9)
  MealType? mealType;

  ResultResponse({
    this.id = "",
    this.explain,
    this.dish,
    this.createDate,
    this.path,
    this.alreadyAte,
    this.mealType,
  });

  ResultResponse copyWith({String? id, List<Dish>? dishes}) {
    return ResultResponse(
      id: id ?? this.id,
      explain: explain,
      dish: dishes ?? dish,
      createDate: createDate,
      path: path,
      alreadyAte: alreadyAte,
      mealType: mealType,
    );
  }

  factory ResultResponse.fromJson(Map<String, dynamic> data) {
    ResultResponse response = ResultResponse();
    DateTime now = DateTime.now();
    response.id = const Uuid().v1();
    response.createDate = now;
    response.explain = data['explain'] as String?;
    response.dish =
        (data['dish'] as List<dynamic>?)?.map((e) => Dish.fromJson(e)).toList();

    return response;
  }

  List<Dish>? getDishes() {
    return dish;
  }

  String getExplain() {
    return explain ?? "";
  }

  void setAteDish(Dish dish) {
    this
        .dish
        ?.firstWhereOrNull((element) => element.id == dish.id)
        ?.setAteDish();
  }

  DateTime getCreatedDate() {
    return createDate ?? DateTime.now();
  }

  void setFilePath(String path) {
    this.path = path;
  }

  String? getFilePath() => path;

  void setEat(bool val) => alreadyAte = val;

  bool getEatState() => alreadyAte ?? false;

  String? getDishName() {
    if (dish.hasItem) {
      return dish?.firstOrNull?.dish;
    }

    return null;
  }
}

enum ResultType {
  canUse(1),
  useButLimit(2),
  cannotUse(3);

  final int id;
  const ResultType(this.id);

  String getTitle(BuildContext context) {
    return switch (this) {
      ResultType.canUse => context.localization.canBeUse,
      ResultType.useButLimit => context.localization.useButLimit,
      ResultType.cannotUse => context.localization.cannotUse,
    };
  }

  String getButtonText(BuildContext context) {
    return switch (this) {
      ResultType.canUse => context.localization.awesomeEatThisFood,
      ResultType.useButLimit => context.localization.eatThisFoodALittle,
      ResultType.cannotUse => context.localization.mustEatThisFood,
    };
  }

  Color getColor(BuildContext context) => switch (this) {
        ResultType.canUse => context.colorScheme.primaryContainer,
        ResultType.cannotUse => context.colorScheme.error.withOpacity(0.7),
        ResultType.useButLimit => context.colorScheme.outlineVariant,
      };

  Color getTextColor(BuildContext context) => switch (this) {
        ResultType.canUse => context.colorScheme.primary,
        ResultType.cannotUse => context.colorScheme.error,
        ResultType.useButLimit => context.colorScheme.outline,
      };

  IconData getIcon() => switch (this) {
        ResultType.canUse => Icons.favorite_border,
        ResultType.cannotUse => Icons.clear,
        ResultType.useButLimit => Icons.check,
      };
}
