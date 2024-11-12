import 'dart:io';

import 'package:ai_tumor_detect/core/network/api_constants.dart';
import 'package:ai_tumor_detect/core/network/api_error_model.dart';
import 'package:dio/dio.dart';

enum DataSource {
  NO_CONNECTION,
  BAD_REQUEST,
  UNAUTHORIZED,
  FORBIDDEN,
  NOT_FOUND,
  SERVER_ERROR,
  TIMEOUT,
  UNKNOWN,
  UNEXPECTED,

  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_FAILURE,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ResponseMessage {
  final String message;
  final DataSource dataSource;

  ResponseMessage({required this.message, required this.dataSource});
}

class ApiErrorHandler {
  static String getErrorMessage(Object error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          // معالجة أخطاء Dio
          switch (error.type) {
            case DioExceptionType.connectionTimeout:
              return "Connection Timeout. Please try again later.";
            case DioExceptionType.sendTimeout:
              return "Send Timeout. Please try again later.";
            case DioExceptionType.receiveTimeout:
              return "Receive Timeout. Please try again later.";
            case DioExceptionType.badResponse:
              // فحص حالة استجابة الخادم
              return _handleHttpError(error.response?.statusCode);
            case DioExceptionType.cancel:
              return "Request was cancelled. Please try again.";
            case DioExceptionType.unknown:
              if (error.error is SocketException) {
                return "No Internet connection. Please check your connection.";
              }
              return "Unexpected error occurred. Please try again.";
            default:
              return "Something went wrong. Please try again.";
          }
        } else if (error is SocketException) {
          return "No Internet connection. Please check your connection.";
        } else {
          return "Unexpected error occurred. Please try again.";
        }
      } catch (_) {
        return "Error occurred while processing error.";
      }
    } else {
      return "An unknown error occurred.";
    }
  }

  // دالة خاصة لمعالجة أخطاء HTTP
  static String _handleHttpError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return ApiErrors.badRequest;
      case 401:
        return ApiErrors.unauthorized;
      case 403:
        return ApiErrors.forbidden;
      case 404:
        return ApiErrors.notFound;
      case 500:
        return ApiErrors.internalServerError;
      case 503:
        return ApiErrors.serviceUnavailable;
      default:
        return "Received invalid status code: $statusCode";
    }
  }
}

extension DataSourceExtension on DataSource {
  ResponseMessage get message {
    switch (this) {
      case DataSource.NO_CONNECTION:
        return ResponseMessage(
          message: "No internet connection",
          dataSource: DataSource.NO_CONNECTION,
        );
      case DataSource.BAD_REQUEST:
        return ResponseMessage(
          message: "Bad request",
          dataSource: DataSource.BAD_REQUEST,
        );
      case DataSource.UNAUTHORIZED:
        return ResponseMessage(
          message: "Unauthorized",
          dataSource: DataSource.UNAUTHORIZED,
        );
      case DataSource.FORBIDDEN:
        return ResponseMessage(
          message: "Forbidden",
          dataSource: DataSource.FORBIDDEN,
        );
      case DataSource.NOT_FOUND:
        return ResponseMessage(
          message: "Not found",
          dataSource: DataSource.NOT_FOUND,
        );
      case DataSource.SERVER_ERROR:
        return ResponseMessage(
          message: "Server error",
          dataSource: DataSource.SERVER_ERROR,
        );
      case DataSource.TIMEOUT:
        return ResponseMessage(
          message: "Connection timeout",
          dataSource: DataSource.TIMEOUT,
        );
      case DataSource.UNKNOWN:
        return ResponseMessage(
          message: "Unknown error",
          dataSource: DataSource.UNKNOWN,
        );
      case DataSource.UNEXPECTED:
        return ResponseMessage(
          message: "Unexpected error",
          dataSource: DataSource.UNEXPECTED,
        );

      case DataSource.INTERNAL_SERVER_ERROR:
        return ResponseMessage(
          message: "Internal server error",
          dataSource: DataSource.INTERNAL_SERVER_ERROR,
        );
      case DataSource.CONNECT_TIMEOUT:
        return ResponseMessage(
          message: "Connection timeout",
          dataSource: DataSource.CONNECT_TIMEOUT,
        );
      case DataSource.RECEIVE_TIMEOUT:
        return ResponseMessage(
          message: "Receive timeout",
          dataSource: DataSource.RECEIVE_TIMEOUT,
        );
      case DataSource.SEND_TIMEOUT:
        return ResponseMessage(
          message: "Send timeout",
          dataSource: DataSource.SEND_TIMEOUT,
        );
      case DataSource.CACHE_FAILURE:
        return ResponseMessage(
          message: "Cache failure",
          dataSource: DataSource.CACHE_FAILURE,
        );
      case DataSource.NO_INTERNET_CONNECTION:
        return ResponseMessage(
          message: "No internet connection",
          dataSource: DataSource.NO_INTERNET_CONNECTION,
        );
      case DataSource.DEFAULT:
        return ResponseMessage(
          message: "Unknown error",
          dataSource: DataSource.DEFAULT,
        );
    }
  }
}

class ErrorHandler implements Exception {
  late ApiError errorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      errorModel = ApiError(
        message: _getErrorMessage(error),
        code: error.response?.statusCode,
      );
    } else {
      errorModel = ApiError(
        message: error.toString(),
        code: 0,
      );
    }
  }

  String _getErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiErrors.timeout;
      case DioExceptionType.sendTimeout:
        return ApiErrors.timeout;
      case DioExceptionType.receiveTimeout:
        return ApiErrors.timeout;
      case DioExceptionType.badResponse:
        return _handleHttpError(error.response?.statusCode);
      case DioExceptionType.cancel:
        return ApiErrors.unknownError;
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return ApiErrors.noInternet;
        }
        return ApiErrors.unknownError;
      default:
        return ApiErrors.unknownError;
    }
  }

  String _handleHttpError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return ApiErrors.badRequest;
      case 401:
        return ApiErrors.unauthorized;
      case 403:
        return ApiErrors.forbidden;
      case 404:
        return ApiErrors.notFound;
      case 500:
        return ApiErrors.internalServerError;
      case 503:
        return ApiErrors.serviceUnavailable;
      default:
        return "Received invalid status code: $statusCode";
    }
  }
}
