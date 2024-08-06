import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mealmate/core.dart';

class MealsController extends GetxController with HiveMixin {
  GlobalKey mealMatchKey = GlobalKey();
  GlobalKey mealSuggestionKey = GlobalKey();
  GlobalKey mealIngredientKey = GlobalKey();

  final Rxn<UserInfo> _userInfo = Rxn<UserInfo>();
  UserInfo? get userInfo => _userInfo.value;
  set userInfo(UserInfo? response) {
    _userInfo.value = response;
  }

  StreamSubscription<BoxEvent>? userStream;

  @override
  void onInit() {
    _listenUserInfoChange();
    super.onInit();
  }

  @override
  void onClose() {
    userStream?.cancel();
    super.onClose();
  }

  Future<void> _listenUserInfoChange() async {
    userInfo = await getUserInfo();
    var box = await Hive.openBox<UserInfo>(AppKeys.userInfoBox);
    userStream = box.watch(key: AppKeys.userInfoKey).listen((event) {
      userInfo = event.value;
      _userInfo.refresh();
    });
  }
}