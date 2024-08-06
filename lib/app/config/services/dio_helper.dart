import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class Method {
  static const String get = "GET";
  static const String post = "POST";
  static const String put = "PUT";
  static const String head = "HEAD";
  static const String delete = "DELETE";
  static const String patch = "PATCH";
}

class DioHelper {
  static final Dio _myDio = Dio(getDefOptions());

  static String Function(dynamic) onErrorHandle = (dynamic responseData) {
    return responseData['error'].toString();
  };

  static BaseOptions getDefOptions() {
    BaseOptions options = BaseOptions();
    options.contentType = ContentType.parse("application/json").toString();
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 20);
    return options;
  }

  static void updateBaseUrl(Dio dio, Uri uri) {
    dio.options.baseUrl = uri.toString();
  }

  static void updateHeader(Dio dio, Map<String, String> headers) {
    Map<String, dynamic> curHeaders = dio.options.headers;
    headers.forEach((key, value) {
      curHeaders[key] = value;
    });
    dio.options.headers = curHeaders;
  }

  static Map<String, dynamic> decodeData(Response? response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return <String, dynamic>{};
    }
    return json.decode(response.data.toString()) as Map<String, dynamic>;
  }

  static Dio currentDio() {
    return _myDio;
  }

  static Dio createDio() {
    var newDio = Dio(getDefOptions());
    return newDio;
  }
}
