import 'package:amap_kit/amap_kit.dart';

typedef OnWeatherChanged = void Function(Weather? weather, dynamic err);

class WeatherSearchKit extends AmapKit {
  WeatherSearchKit() : super('weather');

  OnWeatherChanged? _onWeatherChanged;

  @override
  void handlerData(Map<String, dynamic> data) {
    _onWeatherChanged?.call(Weather.fromJson(data), null);
  }

  @override
  void handlerErr(err) {
    _onWeatherChanged?.call(null, err);
  }

  /// 获取天气数据
  ///
  /// @param city         获取指定城市的天气
  ///
  /// @param onChanged    天气获取的结果回调
  ///
  /// @param type         天气类型
  void weatherSearch(String city,
      {WeatherType type = WeatherType.WEATHER_TYPE_LIVE, required OnWeatherChanged onChanged}) async {
    this._onWeatherChanged = onChanged;
    await AmapKit.methodChannel.invokeMethod('weatherSearch', {'city': city, 'type': type.index});
  }
}
