import 'dart:convert';
import 'dart:io';

class NutritionInput {
  String path;
  String locale;

  NutritionInput({required this.path, required this.locale});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    final bytes = File(path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    data['image'] = img64;
    data['language'] = locale;

    return data;
  }
}