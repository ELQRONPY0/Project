import 'package:ai_tumor_detect/core/network/api_result.dart';
import 'package:ai_tumor_detect/features/auth/data/model/login_response.dart';
import 'package:ai_tumor_detect/features/auth/data/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<ApiResult<LoginResponse>> call({
    required String email,
    required String password,
  }) async {
    final response = await _authRepository.login(
      email: email,
      password: password,
    );

    return response.when(
      success: (data) => ApiResult.success(
        LoginResponse.fromJson(data as Map<String, dynamic>),
      ),
      failure: (error) => ApiResult.failure(error),
    );
  }
}
