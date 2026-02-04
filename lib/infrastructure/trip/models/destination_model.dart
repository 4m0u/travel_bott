import 'package:json_annotation/json_annotation.dart';
import 'package:travel_bott/domain/trip/entities/destination.dart';

part 'destination_model.g.dart';

@JsonSerializable()
class DestinationModel extends Destination {
  const DestinationModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
    super.description,
    super.photoUrl,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      _$DestinationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DestinationModelToJson(this);

  factory DestinationModel.fromDomain(Destination destination) {
    return DestinationModel(
      id: destination.id,
      name: destination.name,
      latitude: destination.latitude,
      longitude: destination.longitude,
      description: destination.description,
      photoUrl: destination.photoUrl,
    );
  }

  Destination toDomain() {
    return Destination(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      description: description,
      photoUrl: photoUrl,
    );
  }
}
