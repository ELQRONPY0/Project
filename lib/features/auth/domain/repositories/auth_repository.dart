import 'package:dartz/dartz.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Exception, UserModel>> signup({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Exception, void>> logout();

  Future<Either<Exception, UserModel?>> getCurrentUser();
}
