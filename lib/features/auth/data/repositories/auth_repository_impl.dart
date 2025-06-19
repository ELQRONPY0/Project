import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final String _baseUrl =
      'http://192.168.1.59:8000/api'; // قم بتغيير هذا إلى عنوان API الخاص بك

  AuthRepositoryImpl() : _dio = Dio() {
    _dio.options.baseUrl = _baseUrl;
  }

  @override
  Future<Either<Exception, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });

      print('Response data (login): \\n${response.data}');

      if (response.data is Map && response.data['user'] != null) {
        final userJson = response.data['user'];
        userJson['token'] = response.data['access_token'];
        return Right(UserModel.fromJson(userJson));
      } else {
        return Left(
            Exception('الاستجابة من السيرفر غير متوقعة: ${response.data}'));
      }
    } on DioException catch (e) {
      return Left(Exception(e.message ?? 'حدث خطأ في تسجيل الدخول'));
    } catch (e) {
      return Left(Exception('حدث خطأ غير متوقع: $e'));
    }
  }

  @override
  Future<Either<Exception, UserModel>> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _dio.post('/register', data: {
        'email': email,
        'password': password,
        'name': name,
      });

      print('Response data (signup): \\n${response.data}');

      if (response.data is Map && response.data['user'] != null) {
        final userJson = response.data['user'];
        userJson['token'] = response.data['token'];
        return Right(UserModel.fromJson(userJson));
      } else {
        print("${response.data}");
        return Left(
            Exception('الاستجابة من السيرفر غير متوقعة: ${response.data}'));
      }
    } on DioException catch (e) {
      return Left(Exception(e.message ?? 'حدث خطأ في التسجيل'));
    } catch (e) {
      return Left(Exception('حدث خطأ غير متوقع: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> logout() async {
    try {
      await _dio.post('/auth/logout');
      return const Right(null);
    } on DioException catch (e) {
      return Left(Exception(e.message ?? 'حدث خطأ في تسجيل الخروج'));
    } catch (e) {
      return Left(Exception('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Exception, UserModel?>> getCurrentUser() async {
    try {
      final response = await _dio.get('/auth/me');
      if (response.data != null) {
        return Right(UserModel.fromJson(response.data));
      } else {
        return const Right(null);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Right(null);
      }
      return Left(Exception(e.message ?? 'حدث خطأ في جلب بيانات المستخدم'));
    } catch (e) {
      return Left(Exception('حدث خطأ غير متوقع'));
    }
  }
}
