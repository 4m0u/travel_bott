import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_bott/infrastructure/trip/models/trip_model.dart';

@lazySingleton
class FirebaseTripDataSource {
  FirebaseTripDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  Future<List<TripModel>> getTrips(String userId) async {
    final snapshot = await _firestore
        .collection('trips')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => TripModel.fromJson(doc.data()..['id'] = doc.id))
        .toList();
  }

  Future<TripModel> getTripById(String id) async {
    final doc = await _firestore.collection('trips').doc(id).get();
    if (!doc.exists) {
      throw FirebaseException(
        plugin: 'cloud_firestore',
        code: 'not-found',
        message: 'Trip not found',
      );
    }
    return TripModel.fromJson(doc.data()!..['id'] = doc.id);
  }

  Future<TripModel> createTrip(String userId, TripModel trip) async {
    final docRef = await _firestore
        .collection('trips')
        .add(trip.toJson()..['userId'] = userId);
    final doc = await docRef.get();
    return TripModel.fromJson(doc.data()!..['id'] = doc.id);
  }

  Future<TripModel> updateTrip(TripModel trip) async {
    await _firestore.collection('trips').doc(trip.id).update(trip.toJson());
    final doc = await _firestore.collection('trips').doc(trip.id).get();
    return TripModel.fromJson(doc.data()!..['id'] = doc.id);
  }

  Future<void> deleteTrip(String id) async {
    await _firestore.collection('trips').doc(id).delete();
  }
}
