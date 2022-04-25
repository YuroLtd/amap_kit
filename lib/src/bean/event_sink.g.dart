// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_sink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventSink _$EventSinkFromJson(Map<String, dynamic> json) => EventSink(
      $enumDecode(_$KidEnumMap, json['kid']),
      $enumDecode(_$BidEnumMap, json['bid']),
      json['code'] as int,
      json['data'],
    );

Map<String, dynamic> _$EventSinkToJson(EventSink instance) => <String, dynamic>{
      'kid': _$KidEnumMap[instance.kid],
      'bid': _$BidEnumMap[instance.bid],
      'code': instance.code,
      'data': instance.data,
    };

const _$KidEnumMap = {
  Kid.location: 10,
  Kid.search: 20,
  Kid.navigate: 30,
  Kid.tool: 40,
};

const _$BidEnumMap = {
  Bid.location: 11,
  Bid.weatherLive: 21,
  Bid.weatherForecast: 22,
};
