import 'package:ai_tumor_detect/core/network/api_result.dart';
import 'package:ai_tumor_detect/features/auth/data/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<ApiResult<void>> call() async {
    return await _authRepository.logout();
  }
}
