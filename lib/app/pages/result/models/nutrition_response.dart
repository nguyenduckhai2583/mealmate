class NutritionResponse {
  String? name;
  String? calories;
  String? protein;
  String? carbohydrates;
  String? fat;

  NutritionResponse({
    this.name,
    this.calories,
    this.protein,
    this.carbohydrates,
    this.fat,
  });

  factory NutritionResponse.fromJson(Map<String, dynamic> data) {
    return NutritionResponse(
      name: data['name'] as String?,
      calories: data['calories'] as String?,
      protein: data['protein'] as String?,
      fat: data['fat'] as String?,
      carbohydrates: data['carbohydrates'] as String?,
    );
  }

  String getName() => name ?? "";

  String getCalories() => calories != null ? "$calories Kcal" : "--";

  String getProteinDisplay() => protein != null ? "${protein}g" : "--";

  String getCarbohydrates() => calories != null ? "${carbohydrates}g" : "--";

  String getFat() => fat != null ? "${fat}g" : "--";
}
