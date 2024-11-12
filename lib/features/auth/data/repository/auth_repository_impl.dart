import 'package:ai_tumor_detect/core/network/api_constants.dart';
import 'package:ai_tumor_detect/core/network/api_result.dart';
import 'package:ai_tumor_detect/core/network/api_services.dart';
import 'package:ai_tumor_detect/features/auth/data/repository/auth_repository.dart';
import 'package:ai_tumor_detect/features/auth/signUp/data/model/sign_up_request_body.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiServices _apiServices;

  AuthRepositoryImpl(this._apiServices);

  @override
  Future<ApiResult<dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiServices.post(
      endPoint: ApiConstants.login,
      body: {
        'email': email,
        'password': password,
      },
      converter: (json) => json,
    );

    return response;
  }

  @override
  Future<ApiResult<dynamic>> register({
    required SignUpRequestBody signUpRequestBody,
  }) async {
    final response = await _apiServices.post(
      endPoint: ApiConstants.register,
      body: signUpRequestBody.toJson(),
      converter: (json) => json,
    );

    return response;
  }

  @override
  Future<ApiResult<dynamic>> logout() async {
    final response = await _apiServices.post(
      endPoint: ApiConstants.logout,
      converter: (json) => json,
    );

    return response;
  }
}
