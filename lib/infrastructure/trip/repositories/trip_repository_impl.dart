import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_bott/domain/core/failures/failure.dart';
import 'package:travel_bott/domain/trip/entities/trip.dart';
import 'package:travel_bott/domain/trip/repositories/i_trip_repository.dart';
import 'package:travel_bott/infrastructure/trip/datasources/firebase_trip_datasource.dart';
import 'package:travel_bott/infrastructure/trip/models/trip_model.dart';
import 'package:travel_bott/infrastructure/user/datasources/firebase_user_datasource.dart';

@LazySingleton(as: ITripRepository)
class TripRepositoryImpl implements ITripRepository {
  TripRepositoryImpl(this._tripDataSource, this._userDataSource);

  final FirebaseTripDataSource _tripDataSource;
  final FirebaseUserDataSource _userDataSource;

  @override
  Future<Either<Failure, List<Trip>>> getTrips() async {
    try {
      final user = await _userDataSource.getCurrentUser();
      if (user == null) return left(const AuthFailure('User not found'));

      final models = await _tripDataSource.getTrips(user.id);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Trip>> getTripById(String id) async {
    try {
      final model = await _tripDataSource.getTripById(id);
      return right(model.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Trip>> createTrip(Trip trip) async {
    try {
      final user = await _userDataSource.getCurrentUser();
      if (user == null) return left(const AuthFailure('User not found'));

      final model = await _tripDataSource.createTrip(
        user.id,
        TripModel.fromDomain(trip),
      );
      return right(model.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Trip>> updateTrip(Trip trip) async {
    try {
      final model = await _tripDataSource.updateTrip(
        TripModel.fromDomain(trip),
      );
      return right(model.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTrip(String id) async {
    try {
      await _tripDataSource.deleteTrip(id);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
