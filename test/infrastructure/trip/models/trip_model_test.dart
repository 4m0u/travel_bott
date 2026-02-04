import 'package:flutter_test/flutter_test.dart';
import 'package:travel_bott/infrastructure/trip/models/trip_model.dart';
import 'package:travel_bott/infrastructure/trip/models/destination_model.dart';
import 'package:travel_bott/domain/trip/entities/trip.dart';
import 'package:travel_bott/domain/trip/entities/destination.dart';

void main() {
  final tStartDate = DateTime.parse('2024-05-01T00:00:00Z');
  final tEndDate = DateTime.parse('2024-05-10T00:00:00Z');

  final tDestinationModel = DestinationModel(
    id: 'd1',
    name: 'Paris',
    latitude: 48.8566,
    longitude: 2.3522,
  );

  final tDestinationEntity = Destination(
    id: 'd1',
    name: 'Paris',
    latitude: 48.8566,
    longitude: 2.3522,
  );

  final tTripModel = TripModel(
    id: 't1',
    title: 'Europe Trip',
    destinations: [tDestinationModel],
    startDate: tStartDate,
    endDate: tEndDate,
    description: 'Adventure',
  );

  final tTripEntity = Trip(
    id: 't1',
    title: 'Europe Trip',
    destinations: [tDestinationEntity],
    startDate: tStartDate,
    endDate: tEndDate,
    description: 'Adventure',
  );

  group('TripModel', () {
    test('should be a subclass of Trip', () {
      expect(tTripModel, isA<Trip>());
    });

    test('fromDomain should return a valid model', () {
      final result = TripModel.fromDomain(tTripEntity);
      expect(result, tTripModel);
    });

    test('toDomain should return a valid entity', () {
      final result = tTripModel.toDomain();
      expect(result, tTripEntity);
    });

    test('fromJson should return a valid model', () {
      final Map<String, dynamic> jsonMap = {
        'id': 't1',
        'title': 'Europe Trip',
        'destinations': [
          {
            'id': 'd1',
            'name': 'Paris',
            'latitude': 48.8566,
            'longitude': 2.3522,
          },
        ],
        'startDate': tStartDate.toIso8601String(),
        'endDate': tEndDate.toIso8601String(),
        'description': 'Adventure',
      };
      final result = TripModel.fromJson(jsonMap);
      expect(result, tTripModel);
    });

    test('toJson should return a JSON map containing proper data', () {
      final result = tTripModel.toJson();
      expect(result['id'], 't1');
      expect(result['destinations'], isA<List>());
      expect(result['destinations'][0]['name'], 'Paris');
    });
  });
}
