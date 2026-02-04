import 'package:json_annotation/json_annotation.dart';
import 'package:travel_bott/domain/trip/entities/trip.dart';
import 'package:travel_bott/infrastructure/trip/models/destination_model.dart';

part 'trip_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TripModel extends Trip {
  const TripModel({
    required super.id,
    required super.title,
    required List<DestinationModel> super.destinations,
    required super.startDate,
    required super.endDate,
    super.description,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TripModelToJson(this);

  factory TripModel.fromDomain(Trip trip) {
    return TripModel(
      id: trip.id,
      title: trip.title,
      destinations: trip.destinations
          .map((d) => DestinationModel.fromDomain(d))
          .toList(),
      startDate: trip.startDate,
      endDate: trip.endDate,
      description: trip.description,
    );
  }

  Trip toDomain() {
    return Trip(
      id: id,
      title: title,
      destinations: destinations.map((d) {
        if (d is DestinationModel) return d.toDomain();
        return d;
      }).toList(),
      startDate: startDate,
      endDate: endDate,
      description: description,
    );
  }
}
