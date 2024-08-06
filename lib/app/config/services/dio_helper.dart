// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../common.dart';

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
  static bool _isDebug = false;
  static HttpConfig _httpConfig = HttpConfigDefault();
  static ErrorMessageDelegate errorText = ErrorMessageDelegateDefault();
  static String Function(dynamic) onErrorHandle = (dynamic responseData) {
    if (responseData == null || responseData is! Map<String, dynamic>) {
      return errorText.somethingWentWrong;
    }
    return responseData['error'].toString();
  };
  static List<int> refreshTokenStatus = [401];

  /// get Def Options.
  static BaseOptions getDefOptions() {
    BaseOptions options = BaseOptions();
    options.contentType = ContentType.parse("application/json").toString();
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 20);
    return options;
  }

  static HttpConfig getConf() {
    return _httpConfig;
  }

  static void setConf(HttpConfig config) {
    _httpConfig = config;
  }

  static void setClientAdapter(Dio dio) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        LogUtils.d("X509Certificate: port: $port, host: $host, cer: $cert");
        return true;
      };
      return client;
    };
  }

  static void updateBaseUrl(Dio dio, Uri uri) {
    dio.options.baseUrl = uri.toString();
    LogUtils.d("updateBaseUrl: ${dio.options.baseUrl}");
    setClientAdapter(dio);
  }

  static void updateTimeOut(
    Dio dio, {
    Duration connectTimeOut = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 20),
  }) {
    dio.options.connectTimeout = connectTimeOut;
    dio.options.receiveTimeout = receiveTimeout;
  }

  static void updateHeader(Dio dio, Map<String, String> headers) {
    Map<String, dynamic> curHeaders = dio.options.headers;
    headers.forEach((key, value) {
      curHeaders[key] = value;
    });
    dio.options.headers = curHeaders;
  }

  static void setCookie(Dio dio, String cookie) {
    Map<String, dynamic> headers = <String, dynamic>{};
    headers["Cookie"] = cookie;
    dio.options.headers.addAll(headers);
  }

  /// Enable debug
  static void setDebugMode(bool isEnabled) {
    _isDebug = isEnabled;
  }

  /// Decode response data.
  static Map<String, dynamic> decodeData(Response? response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return <String, dynamic>{};
    }
    return json.decode(response.data.toString()) as Map<String, dynamic>;
  }

  static void clearInterceptors(Dio dio) {
    dio.interceptors.clear();
  }

  static void setInterceptorRefreshToken({
    required Dio dio,
    required Future<RefreshTokenRes<String>> Function() refreshToken,
    void Function()? cancelRefreshHandle,
    void Function()? failRefreshHandle,
  }) {
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
        onError: (error, handler) async {
          /// Assume 401 stands for token expired
          int? responseStatus = error.response?.statusCode;
          if (responseStatus != null &&
              refreshTokenStatus.contains(responseStatus)) {
            LogUtils.d('The token has expired, need to receive new token');
            RequestOptions requestOptions = error.response!.requestOptions;
            RefreshTokenRes<String> refreshTokenRes = await refreshToken();

            /// update [Token]
            switch (refreshTokenRes.status) {
              case RefreshTokenStatus.success:
                var options = Options(
                  method: requestOptions.method,
                  headers: requestOptions.headers,
                  sendTimeout: requestOptions.sendTimeout,
                  receiveTimeout: requestOptions.receiveTimeout,
                );
                String? newToken = refreshTokenRes.data;
                if (newToken != null && newToken.isNotEmpty) {
                  refreshTokenRes.authorizationHeader?.forEach(
                    (key, dynamic value) {
                      options.headers![key] = value;
                    },
                  );
                }

                try {
                  final res = await dio.request<dynamic>(
                    requestOptions.path,
                    data: requestOptions.data,
                    queryParameters: requestOptions.queryParameters,
                    options: options,
                  );
                  return handler.resolve(res);
                } on DioError catch (error) {
                  return handler.next(error); // or handler.reject(error);
                }
              case RefreshTokenStatus.failed:
                failRefreshHandle?.call();
                return handler.reject(
                  DioException(requestOptions: requestOptions),
                );
              case RefreshTokenStatus.cancel:
                cancelRefreshHandle?.call();
                return handler.reject(error);
            }
          }
          ///continue throw error
          return handler.next(error);
        },
      ),
    );
  }

  static void setInterceptorRetry(
    Dio dio, {
    int retries = 3,
    List<Duration> retryDelays = const [
      Duration(seconds: 1),
      Duration(seconds: 3),
      Duration(seconds: 5)
    ],
  }) {
    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: (log) => LogUtils.d("RetryInterceptor: $log"),
      retries: retries,
      retryDelays: retryDelays,
      retryEvaluator: DefaultRetryEvaluator(const {
        status408RequestTimeout,
        status429TooManyRequests,
        status504GatewayTimeout,
        status440LoginTimeout,
        status499ClientClosedRequest,
        status460ClientClosedRequest,
        status522ConnectionTimedOut,
        status524TimeoutOccurred,
      }).evaluate,
    ));
  }

  static void setInterceptorLogger(Dio dio,
      {bool? printOnSuccess, bool convertFormData = true}) {
    dio.interceptors.add(LoggerDioInterceptor(
      printOnSuccess: printOnSuccess,
      convertFormData: convertFormData,
    ));
  }

  //Get dio
  static Dio currentDio() {
    return _myDio;
  }

  //Create dio builder
  static Dio createDio() {
    var newDio = Dio(getDefOptions());
    setClientAdapter(newDio);
    return newDio;
  }

  //clone Dio from
  static Dio cloneDio({Dio? dio}) {
    Dio source = dio ?? currentDio();
    var newDio = Dio(source.options.copyWith());
    setClientAdapter(newDio);
    return newDio;
  }

  /// print Http Log.
  static void printHttpLog(Response response) {
    if (!_isDebug) {
      return;
    }
    try {
      LogUtils.d(
          "----------------Http Log----------------\n[statusCode]:\t${response.statusCode}\n[request]:\t${_getOptionsStr(response.requestOptions)}\n[response]:\t${response.data}\n----------------End Log----------------");
    } catch (ex) {
      LogUtils.e("Http Log  error......");
    }
  }

  /// get Options Str.
  static String _getOptionsStr(RequestOptions request) {
    return "method: ${request.method}  baseUrl: ${request.baseUrl}  path: ${request.path}";
  }
}
