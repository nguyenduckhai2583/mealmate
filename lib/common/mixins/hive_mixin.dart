import 'package:hive/hive.dart';
import 'package:mealmate/core.dart';

mixin HiveMixin {
  Future<UserInfo> getUserInfo() async {
    var box = await Hive.openBox<UserInfo>(AppKeys.userInfoBox);
    var user = box.get(AppKeys.userInfoKey);
    return user ?? UserInfo();
  }

  Future<void> saveUser(UserInfo? userInfo) async {
    if (userInfo == null) return;

    var box = await Hive.openBox<UserInfo>(AppKeys.userInfoBox);
    box.put(AppKeys.userInfoKey, userInfo);
  }

  Future<List<ResultResponse>> getAllResult() async {
    var box = await Hive.openBox<ResultResponse>(AppKeys.mealResultBox);
    return box.values.toList();
  }

  Future<void> saveResult(ResultResponse? result) async {
    if (result == null) return;

    var box = await Hive.openBox<ResultResponse>(AppKeys.mealResultBox);
    box.put(result.id, result);
  }
}