import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_bott/domain/trip/entities/destination.dart';

part 'trip.g.dart';

@JsonSerializable(explicitToJson: true)
class Trip extends Equatable {
  const Trip({
    required this.id,
    required this.title,
    required this.destinations,
    required this.startDate,
    required this.endDate,
    this.description,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
  Map<String, dynamic> toJson() => _$TripToJson(this);

  final String id;
  final String title;
  final List<Destination> destinations;
  final DateTime startDate;
  final DateTime endDate;
  final String? description;

  @override
  List<Object?> get props => [
    id,
    title,
    destinations,
    startDate,
    endDate,
    description,
  ];
}
