import 'package:fpdart/fpdart.dart';
import 'package:travel_bott/domain/core/failures/failure.dart';
import 'package:travel_bott/domain/trip/entities/trip.dart';

abstract class ITripRepository {
  Future<Either<Failure, List<Trip>>> getTrips();
  Future<Either<Failure, Trip>> getTripById(String id);
  Future<Either<Failure, Trip>> createTrip(Trip trip);
  Future<Either<Failure, Trip>> updateTrip(Trip trip);
  Future<Either<Failure, void>> deleteTrip(String id);
}
