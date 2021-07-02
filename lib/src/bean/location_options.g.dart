// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationOptions _$LocationOptionsFromJson(Map<String, dynamic> json) {
  return LocationOptions(
    locationMode:
        _$enumDecodeNullable(_$LocationModeEnumMap, json['locationMode']),
    locationPurpose:
        _$enumDecodeNullable(_$LocationPurposeEnumMap, json['locationPurpose']),
    isOnceLocation: json['isOnceLocation'] as bool?,
    isOnceLocationLatest: json['isOnceLocationLatest'] as bool?,
    interval: json['interval'] as int?,
    isNeedAddress: json['isNeedAddress'] as bool?,
    isMockEnable: json['isMockEnable'] as bool?,
    httpTimeOut: json['httpTimeOut'] as int?,
    isLocationCacheEnable: json['isLocationCacheEnable'] as bool?,
    locationProtocol: _$enumDecodeNullable(
        _$LocationProtocolEnumMap, json['locationProtocol']),
    isWifiScan: json['isWifiScan'] as bool?,
  );
}

Map<String, dynamic> _$LocationOptionsToJson(LocationOptions instance) =>
    <String, dynamic>{
      'locationMode': _$LocationModeEnumMap[instance.locationMode],
      'locationPurpose': _$LocationPurposeEnumMap[instance.locationPurpose],
      'isOnceLocation': instance.isOnceLocation,
      'isOnceLocationLatest': instance.isOnceLocationLatest,
      'interval': instance.interval,
      'isNeedAddress': instance.isNeedAddress,
      'isMockEnable': instance.isMockEnable,
      'httpTimeOut': instance.httpTimeOut,
      'isLocationCacheEnable': instance.isLocationCacheEnable,
      'locationProtocol': _$LocationProtocolEnumMap[instance.locationProtocol],
      'isWifiScan': instance.isWifiScan,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$LocationModeEnumMap = {
  LocationMode.Battery_Saving: 'Battery_Saving',
  LocationMode.Device_Sensors: 'Device_Sensors',
  LocationMode.Hight_Accuracy: 'Hight_Accuracy',
};

const _$LocationPurposeEnumMap = {
  LocationPurpose.SignIn: 'SignIn',
  LocationPurpose.Transport: 'Transport',
  LocationPurpose.Sport: 'Sport',
};

const _$LocationProtocolEnumMap = {
  LocationProtocol.HTTP: 'HTTP',
  LocationProtocol.HTTPS: 'HTTPS',
};
