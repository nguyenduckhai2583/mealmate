import 'package:dio/dio.dart';
import 'package:mealmate/core.dart';

abstract class ApiClient {
  Dio service = DioHelper.currentDio();

  Future<BaseResp<T>> request<T>(
    String method,
    String path, {
    dynamic data,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
    required dynamic Function(dynamic) onDeserialize,
    Options? options,
    Function(int, int)? onSendProgress,
  }) async {
    service.options.method = method;
    try {
      final response = await service.request<dynamic>(path,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          options: options,
          onSendProgress: onSendProgress);

      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 300) {
        return BaseResp.dataFromJson(
          json: response.data,
          onDeserialize: onDeserialize,
          statusCode: response.statusCode ?? -1,
          response: response,
        );
      } else {
        String errMessage = DioHelper.onErrorHandle(response);
        return BaseResp.withError(
          statusCode: response.statusCode ?? -1,
          errorMsg: errMessage,
          response: response,
        );
      }
    } catch (error) {
      return BaseResp.withError(
        statusCode: -1,
        errorMsg: "Something went wrong",
      );
    }
  }
}
