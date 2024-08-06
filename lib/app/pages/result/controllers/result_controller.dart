import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';
import 'package:uuid/uuid.dart';

class ResultController extends GetxController with HiveMixin {
  late MealRemoteHttp mealRemoteHttp;
  String? filePath;

  final Rxn<ResultResponse> _response = Rxn<ResultResponse>();
  ResultResponse? get responseRx => _response.value;
  set response(ResultResponse? response) {
    _response.value = response;
  }

  MealType? mealType;
  RxBool loading = true.obs;

  @override
  void onInit() {
    mealRemoteHttp = Get.find<MealRemoteHttp>();
    if (Get.arguments != null && Get.arguments is ResultInput) {
      var input = Get.arguments as ResultInput;
      var result = input.result;
      mealType = input.mealType ?? result?.mealType;
      if (result != null) {
        _setResult(result);
        return;
      }
      filePath = input.filePath;
      _getMealResult(
        filePath,
        mealType: input.mealType,
        mealTime: input.mealTime,
      );
    }
    super.onInit();
  }

  void _setResult(ResultResponse result) {
    response = result;
    filePath = result.path;
    loading.value = false;
  }

  void _getMealResult(
    String? path, {
    MealType? mealType,
    MealTime? mealTime,
  }) async {
    if (Get.context == null) {
      loading.value = false;
    }

    var rq = await _getUserRequest(Get.context!);

    if (path != null) {
      final bytes = File(path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      rq['image'] = img64;
    }

    if (mealTime != null) {
      rq['meal'] = mealTime.name;
    }

    var locale = LocalizationService.getLocale();
    rq['language'] = locale.languageCode;

    var result = await mealRemoteHttp.getAdvise(rq, mealType: mealType);
    if (result.isSuccess()) {
      response = result.data;
      responseRx?.mealType = mealType;
    }

    loading.value = false;
  }

  Future<Map<String, dynamic>> _getUserRequest(BuildContext context) async {
    var user = await getUserInfo();
    if (context.mounted) {
      var request = user.toRequest(context);
      return request;
    }

    return {};
  }

  Future<void> eatThisFood({Dish? dish}) async {
    dish?.setAteDish();
    ResultResponse? temp;

    if (dish != null) {
      responseRx?.setAteDish(dish);
    } else {
      responseRx?.setEat(true);
    }

    temp = responseRx?.copyWith(
      id: const Uuid().v1(),
      dishes: dish != null ? [dish] : null,
    );

    if (filePath case String filePath) {
      File file = await FileUtils.copyFileToStorage(filePath);
      temp?.setFilePath(file.path);
    }

    _response.refresh();
    saveResult(temp);
  }
}
