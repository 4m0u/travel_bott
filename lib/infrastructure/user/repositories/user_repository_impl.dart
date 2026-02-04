import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_bott/domain/core/failures/failure.dart';
import 'package:travel_bott/domain/user/entities/user.dart';
import 'package:travel_bott/domain/user/repositories/i_user_repository.dart';
import 'package:travel_bott/infrastructure/user/datasources/firebase_user_datasource.dart';

@LazySingleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  UserRepositoryImpl(this._dataSource);

  final FirebaseUserDataSource _dataSource;

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final userModel = await _dataSource.getCurrentUser();
      if (userModel == null) {
        return left(const AuthFailure('User not logged in'));
      }
      return right(userModel.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _dataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(userModel.toDomain());
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final userModel = await _dataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      return right(userModel.toDomain());
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _dataSource.signOut();
      return right(null);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }
}
