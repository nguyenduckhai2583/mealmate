import 'package:mealmate/core.dart';

class MealRemoteHttp extends ApiClient {
  Future<BaseResp<ResultResponse>> getAdvise(
    Map rq, {
    MealType? mealType,
  }) async {
    var api = switch (mealType) {
      MealType.mealSuggestion => AppApi.mealSuggestion,
      MealType.mealIngredient => AppApi.mealIngredient,
      _ => AppApi.mealMatch,
    };
    return request<ResultResponse>(
      Method.post,
      api,
      data: rq,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map<String, dynamic>) {
          return ResultResponse.fromJson(jsonValue['response']);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<NutritionResponse>>> getNutritionInfo(
    NutritionInput nutritionInput,
  ) async {
    return request<List<NutritionResponse>>(
      Method.post,
      AppApi.nutrition,
      data: nutritionInput.toJson(),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map<String, dynamic>) {
          var result = jsonValue['response']['result'];
          if (result == null && result! is List) return [];

          return (result as List<dynamic>)
              .map((dynamic e) =>
                  NutritionResponse.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }
}
