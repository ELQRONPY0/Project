import 'package:ai_tumor_detect/core/network/api_error_handler.dart';
import 'package:ai_tumor_detect/core/network/api_result.dart';
import 'package:ai_tumor_detect/core/network/dio_factory.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio = DioFactory.getDio();

  Future<ApiResult<T>> post<T>({
    required String endPoint,
    required T Function(Map<String, dynamic> json) converter,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await _dio.post(
        endPoint,
        data: isFormData ? FormData.fromMap(body ?? {}) : body,
        queryParameters: queryParameters,
      );

      return ApiResult.success(
        converter(response.data as Map<String, dynamic>),
      );
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<T>> get<T>({
    required String endPoint,
    required T Function(Map<String, dynamic> json) converter,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endPoint,
        queryParameters: queryParameters,
      );

      return ApiResult.success(
        converter(response.data as Map<String, dynamic>),
      );
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<T>> put<T>({
    required String endPoint,
    required T Function(Map<String, dynamic> json) converter,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(
        endPoint,
        data: body,
        queryParameters: queryParameters,
      );

      return ApiResult.success(
        converter(response.data as Map<String, dynamic>),
      );
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<T>> delete<T>({
    required String endPoint,
    required T Function(Map<String, dynamic> json) converter,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        endPoint,
        data: body,
        queryParameters: queryParameters,
      );

      return ApiResult.success(
        converter(response.data as Map<String, dynamic>),
      );
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
