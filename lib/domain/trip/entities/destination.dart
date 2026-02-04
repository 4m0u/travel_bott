import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'destination.g.dart';

@JsonSerializable()
class Destination extends Equatable {
  const Destination({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.description,
    this.photoUrl,
  });

  factory Destination.fromJson(Map<String, dynamic> json) =>
      _$DestinationFromJson(json);
  Map<String, dynamic> toJson() => _$DestinationToJson(this);

  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String? description;
  final String? photoUrl;

  @override
  List<Object?> get props => [
    id,
    name,
    latitude,
    longitude,
    description,
    photoUrl,
  ];
}
