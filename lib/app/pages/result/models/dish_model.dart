import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:mealmate/core.dart';

part 'dish_model.g.dart';

@HiveType(typeId: 3)
class Dish {
  @HiveField(0)
  String id;
  @HiveField(1)
  String? dish;
  @HiveField(2)
  List<String>? ingredients;
  @HiveField(3)
  String? instruction;
  @HiveField(4)
  bool alreadyAte;
  @HiveField(5)
  double? calories;
  @HiveField(6)
  int? result;

  Dish({
    this.id = "",
    this.dish,
    this.ingredients,
    this.instruction,
    this.alreadyAte = false,
    this.result,
    this.calories,
  });

  String? getDishName() => dish;

  List<String>? getDishIngredients() => ingredients;

  String? getDishInstruction() => instruction;

  void setAteDish() {
    alreadyAte = true;
  }

  ResultType getResultType() {
    if (result == null) {
      return ResultType.canUse;
    }

    var type = ResultType.values.firstWhereOrNull(
      (element) => element.id == result,
    );

    return type ?? ResultType.canUse;
  }

  int? getCalories() {
    if (calories == null) return null;

    if (calories! > 0) {
      return calories!.toInt();
    }

    return null;
  }

  factory Dish.fromJson(Map<String, dynamic> data) {
    var caloData = data['calories'];
    double? calo;
    if (caloData is String) {
      calo = double.tryParse(caloData);
    } else if (caloData is num) {
      calo = (data['calories'] as num?)?.toDouble();
    }

    return Dish(
      id: const Uuid().v1(),
      dish: data['dish'] as String?,
      ingredients: (data['ingredients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      instruction: data['instruction'] as String?,
      result: data['result'] as int?,
      calories: calo,
    );
  }
}
