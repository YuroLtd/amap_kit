import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather extends Object {
  String adCode;

  String province;

  String city;

  String reportTime;

  Weather(
    this.adCode,
    this.province,
    this.city,
    this.reportTime,
  );

  factory Weather.fromJson(Map<String, dynamic> srcJson) => _$WeatherFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class LiveWeather extends Weather {
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
    String adCode,
    String province,
    String city,
    String reportTime,
  ) : super(adCode, province, city, reportTime);

  factory LiveWeather.fromJson(Map<String, dynamic> srcJson) => _$LiveWeatherFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$LiveWeatherToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ForecastWeather extends Weather {
  List<ForecastWeatherByDay> forecasts;

  ForecastWeather(
    this.forecasts,
    String adCode,
    String province,
    String city,
    String reportTime,
  ) : super(adCode, province, city, reportTime);

  factory ForecastWeather.fromJson(Map<String, dynamic> srcJson) => _$ForecastWeatherFromJson(srcJson);

  @override
  Map<String, dynamic> toJson() => _$ForecastWeatherToJson(this);
}

@JsonSerializable()
class ForecastWeatherByDay extends Object {
  String date;

  String dayTemp;

  String dayWeather;

  String dayWindDirection;

  String dayWindPower;

  String nightTemp;

  String nightWeather;

  String nightWindDirection;

  String nightWindPower;

  ForecastWeatherByDay(
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

  factory ForecastWeatherByDay.fromJson(Map<String, dynamic> srcJson) => _$ForecastWeatherByDayFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ForecastWeatherByDayToJson(this);
}
