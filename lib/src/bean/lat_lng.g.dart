// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lat_lng.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return LatLng(
    (json['longitude'] as num).toDouble(),
    (json['latitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
