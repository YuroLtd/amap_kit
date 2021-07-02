import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather extends Object {
  String adCode;

  String province;

  String city;

  String reportTime;

  LiveWeather? live;

  List<ForecastWeather>? forecast;

  Weather(
    this.adCode,
    this.province,
    this.city,
    this.reportTime,
    this.live,
    this.forecast,
  );

  factory Weather.fromJson(Map<String, dynamic> srcJson) => _$WeatherFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class LiveWeather extends Object {
  String temperature;

  String humidity;

  String weather;

  String windDirection;

  String windPower;

  LiveWeather(
    this.temperature,
    this.humidity,
    this.weather,
    this.windDirection,
    this.windPower,
  );

  factory LiveWeather.fromJson(Map<String, dynamic> srcJson) => _$LiveWeatherFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LiveWeatherToJson(this);
}

@JsonSerializable()
class ForecastWeather extends Object {
  String date;

  String dayTemp;

  String dayWeather;

  String dayWindDirection;

  String dayWindPower;

  String nightTemp;

  String nightWeather;

  String nightWindDirection;

  String nightWindPower;

  ForecastWeather(
    this.date,
    this.dayTemp,
    this.dayWeather,
    this.dayWindDirection,
    this.dayWindPower,
    this.nightTemp,
    this.nightWeather,
    this.nightWindDirection,
    this.nightWindPower,
  );

  factory ForecastWeather.fromJson(Map<String, dynamic> srcJson) => _$ForecastWeatherFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ForecastWeatherToJson(this);
}
