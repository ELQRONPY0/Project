import 'package:ai_tumor_detect/core/network/api_result.dart';
import 'package:ai_tumor_detect/features/auth/data/model/sign_up_request_body.dart';

abstract class AuthRepository {
  Future<ApiResult<dynamic>> login({
    required String email,
    required String password,
  });

  Future<ApiResult<dynamic>> register({
    required SignUpRequestBody signUpRequestBody,
  });

  Future<ApiResult<dynamic>> logout();
}
