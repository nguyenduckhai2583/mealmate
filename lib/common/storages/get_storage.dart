import 'package:get_storage/get_storage.dart';

class GetStorageBox {
  GetStorage box = GetStorage();

  void setData(String key, dynamic value) => GetStorage().write(key, value);

  int getInt(String key, {int defaultVal = 0}) =>
      GetStorage().read<int>(key) ?? defaultVal;

  String getString(String key, {String defaultVal = ""}) =>
      GetStorage().read<String>(key) ?? defaultVal;

  bool getBool(String key, {bool defaultVal = false}) =>
      GetStorage().read<bool>(key) ?? defaultVal;

  double getDouble(String key, {double defaultVal = 0}) =>
      GetStorage().read<double>(key) ?? defaultVal;

  void clearData() async => GetStorage().erase();
}
