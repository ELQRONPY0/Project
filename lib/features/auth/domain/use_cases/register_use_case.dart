import 'package:ai_tumor_detect/core/network/api_result.dart';
import 'package:ai_tumor_detect/features/auth/data/model/login_response.dart';
import 'package:ai_tumor_detect/features/auth/data/repository/auth_repository.dart';
import 'package:ai_tumor_detect/features/auth/signUp/data/model/sign_up_request_body.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<ApiResult<LoginResponse>> call({
    required SignUpRequestBody signUpRequestBody,
  }) async {
    final response = await _authRepository.register(
      signUpRequestBody: signUpRequestBody,
    );

    return response.when(
      success: (data) => ApiResult.success(
        LoginResponse.fromJson(data as Map<String, dynamic>),
      ),
      failure: (error) => ApiResult.failure(error),
    );
  }
}
