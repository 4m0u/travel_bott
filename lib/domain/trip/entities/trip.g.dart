// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
  id: json['id'] as String,
  title: json['title'] as String,
  destinations: (json['destinations'] as List<dynamic>)
      .map((e) => Destination.fromJson(e as Map<String, dynamic>))
      .toList(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  description: json['description'] as String?,
);

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'destinations': instance.destinations.map((e) => e.toJson()).toList(),
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'description': instance.description,
};
