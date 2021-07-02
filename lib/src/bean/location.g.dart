// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    (json['latitude'] as num).toDouble(),
    (json['longitude'] as num).toDouble(),
    (json['altitude'] as num).toDouble(),
    (json['accuracy'] as num).toDouble(),
    json['address'] as String,
    json['country'] as String,
    json['province'] as String,
    json['city'] as String,
    json['district'] as String,
    json['street'] as String,
    json['streetNum'] as String,
    json['floor'] as String,
    json['cityCode'] as String,
    json['adCode'] as String,
    json['aoiName'] as String,
    json['poiName'] as String,
    json['description'] as String,
    (json['speed'] as num).toDouble(),
    (json['bearing'] as num).toDouble(),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'altitude': instance.altitude,
      'accuracy': instance.accuracy,
      'address': instance.address,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'district': instance.district,
      'street': instance.street,
      'streetNum': instance.streetNum,
      'floor': instance.floor,
      'cityCode': instance.cityCode,
      'adCode': instance.adCode,
      'aoiName': instance.aoiName,
      'poiName': instance.poiName,
      'description': instance.description,
      'speed': instance.speed,
      'bearing': instance.bearing,
    };
