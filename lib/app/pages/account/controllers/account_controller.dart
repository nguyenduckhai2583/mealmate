import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mealmate/core.dart';

class AccountController extends GetxController with HiveMixin {
  final Rxn<Locale> _currentLocal = Rxn<Locale>();
  Locale? get currentLocal => _currentLocal.value;
  set currentLocal(Locale? val) {
    _currentLocal.value = val;
  }

  final Rxn<UserInfo> _userInfo = Rxn<UserInfo>();
  UserInfo? get userInfo => _userInfo.value;
  set userInfo(UserInfo? response) {
    _userInfo.value = response;
  }

  StreamSubscription<BoxEvent>? userStream;

  @override
  void onInit() {
    getLocale();
    _listenUserInfoChange();
    super.onInit();
  }

  @override
  void onClose() {
    userStream?.cancel();
    super.onClose();
  }

  void getLocale() {
    currentLocal = LocalizationService.getLocale();
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