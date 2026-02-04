import 'package:fpdart/fpdart.dart';
import 'package:travel_bott/domain/core/failures/failure.dart';
import 'package:travel_bott/domain/user/entities/user.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? name,
  });
  Future<Either<Failure, void>> signOut();
}
