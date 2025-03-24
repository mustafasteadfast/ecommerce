import 'package:dio/dio.dart';
import 'dart:developer' as developer;

class DioClient {
  DioClient._internal();

  static final DioClient _instance = DioClient._internal();

  static DioClient get instance => _instance;

  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://143.198.199.41:9999',
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer 86|GktVElGeNp1A45cUkS7eNoG512suv2vIYmk1rfIt291a82be',
    },
  ))..interceptors.add(Logger());
}

class Logger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    developer.log('REQUEST[${options.method}] => PATH: ${options.path}');
    developer.log('Request Headers: ${options.headers}');
    developer.log('Query Parameters: ${options.queryParameters}');
    if (options.data != null) {
      developer.log('Request Body: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    developer.log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    developer.log('Response Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    developer.log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    developer.log('Error Message: ${err.message}');
    if (err.response != null) {
      developer.log('Error Response: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}