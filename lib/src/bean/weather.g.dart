// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    json['adCode'] as String,
    json['province'] as String,
    json['city'] as String,
    json['reportTime'] as String,
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'adCode': instance.adCode,
      'province': instance.province,
      'city': instance.city,
      'reportTime': instance.reportTime,
    };

LiveWeather _$LiveWeatherFromJson(Map<String, dynamic> json) {
  return LiveWeather(
    json['temperature'] as String,
    json['humidity'] as String,
    json['weather'] as String,
    json['windDirection'] as String,
    json['windPower'] as String,
    json['adCode'] as String,
    json['province'] as String,
    json['city'] as String,
    json['reportTime'] as String,
  );
}

Map<String, dynamic> _$LiveWeatherToJson(LiveWeather instance) =>
    <String, dynamic>{
      'adCode': instance.adCode,
      'province': instance.province,
      'city': instance.city,
      'reportTime': instance.reportTime,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'weather': instance.weather,
      'windDirection': instance.windDirection,
      'windPower': instance.windPower,
    };

ForecastWeather _$ForecastWeatherFromJson(Map<String, dynamic> json) {
  return ForecastWeather(
    (json['forecasts'] as List<dynamic>)
        .map((e) => ForecastWeatherByDay.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['adCode'] as String,
    json['province'] as String,
    json['city'] as String,
    json['reportTime'] as String,
  );
}

Map<String, dynamic> _$ForecastWeatherToJson(ForecastWeather instance) =>
    <String, dynamic>{
      'adCode': instance.adCode,
      'province': instance.province,
      'city': instance.city,
      'reportTime': instance.reportTime,
      'forecasts': instance.forecasts,
    };

ForecastWeatherByDay _$ForecastWeatherByDayFromJson(Map<String, dynamic> json) {
  return ForecastWeatherByDay(
    json['date'] as String,
    json['dayTemp'] as String,
    json['dayWeather'] as String,
    json['dayWindDirection'] as String,
    json['dayWindPower'] as String,
    json['nightTemp'] as String,
    json['nightWeather'] as String,
    json['nightWindDirection'] as String,
    json['nightWindPower'] as String,
  );
}

Map<String, dynamic> _$ForecastWeatherByDayToJson(
        ForecastWeatherByDay instance) =>
    <String, dynamic>{
      'date': instance.date,
      'dayTemp': instance.dayTemp,
      'dayWeather': instance.dayWeather,
      'dayWindDirection': instance.dayWindDirection,
      'dayWindPower': instance.dayWindPower,
      'nightTemp': instance.nightTemp,
      'nightWeather': instance.nightWeather,
      'nightWindDirection': instance.nightWindDirection,
      'nightWindPower': instance.nightWindPower,
    };
