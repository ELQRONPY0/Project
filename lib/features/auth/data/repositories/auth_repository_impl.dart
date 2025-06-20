import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final String _baseUrl =
      'http://192.168.1.59:8000/api'; // قم بتغيير هذا إلى عنوان API الخاص بك
  String? _token;
  SharedPreferences? _prefs;

  AuthRepositoryImpl() : _dio = Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs?.getString('token');
    if (_token != null) {
      _updateToken(_token);
    }
  }

  void _updateToken(String? token) {
    _token = token;
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      _prefs?.setString('token', token);
    } else {
      _dio.options.headers.remove('Authorization');
      _prefs?.remove('token');
    }
  }

  @override
  Future<void> initPrefs() async {
    await _initPrefs();
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

      if (response.data != null) {
        final accessToken = response.data['access_token'] as String;
        _updateToken(accessToken);

        final userJson = response.data['user'] as Map<String, dynamic>;
        userJson['token'] = accessToken;
        return Right(UserModel.fromJson(userJson));
      } else {
        return Left(Exception('الاستجابة من السيرفر غير متوقعة'));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        return Left(Exception('خطأ في الخادم - يرجى المحاولة مرة أخرى لاحقاً'));
      }
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

      if (response.data != null && response.data['user'] != null) {
        final userJson = response.data['user'] as Map<String, dynamic>;
        userJson['token'] = response.data['access_token'];
        return Right(UserModel.fromJson(userJson));
      } else {
        return Left(Exception('الاستجابة من السيرفر غير متوقعة'));
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
      _updateToken(null);

      return const Right(null);
    } on DioException catch (e) {
      _updateToken(null);
      return Left(Exception(e.message ?? 'حدث خطأ في تسجيل الخروج'));
    } catch (e) {
      _updateToken(null);
      return Left(Exception('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Exception, UserModel?>> getCurrentUser() async {
    try {
      if (_token == null) {
        return const Right(null);
      }

      final response = await _dio.get('/auth/user-profile');

      if (response.data != null && response.data is Map<String, dynamic>) {
        final userJson = response.data as Map<String, dynamic>;
        userJson['token'] = _token;
        return Right(UserModel.fromJson(userJson));
      } else {
        return const Right(null);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _updateToken(null);
        return const Right(null);
      }
      if (e.response?.statusCode == 500) {
        return Left(Exception('خطأ في الخادم - يرجى المحاولة مرة أخرى لاحقاً'));
      }
      return Left(Exception(e.message ?? 'حدث خطأ في جلب بيانات المستخدم'));
    } catch (e) {
      return Left(Exception('حدث خطأ غير متوقع: $e'));
    }
  }
}
