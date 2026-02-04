// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Destination _$DestinationFromJson(Map<String, dynamic> json) => Destination(
  id: json['id'] as String,
  name: json['name'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  description: json['description'] as String?,
  photoUrl: json['photoUrl'] as String?,
);

Map<String, dynamic> _$DestinationToJson(Destination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
    };
