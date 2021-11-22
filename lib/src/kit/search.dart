import 'package:amap_kit/amap_kit.dart';
import 'package:amap_kit/src/util/map_ext.dart';
import 'kit.dart';

typedef OnLiveWeather = void Function(LiveWeather liveWeather);
typedef OnForecastWeather = void Function(ForecastWeather forecastWeather);

class SearchKit extends Kit {
  static const _WEATHER_LIVE = 20;
  static const _WEATHER_FORECAST = 21;

  OnLiveWeather? _onLiveWeather;
  OnForecastWeather? _onForecastWeather;

  @override
  void handlerData(int bid, data) {
    switch (bid) {
      case _WEATHER_LIVE:
        _onLiveWeather?.call(LiveWeather.fromJson(Map.castFrom(data)));
        break;
      case _WEATHER_FORECAST:
        _onForecastWeather?.call(ForecastWeather.fromJson(Map.castFrom(data)..deepCast()));
        break;
    }
  }

  /// 获取实时天气数据
  ///
  /// @param city         获取指定城市的天气
  ///
  /// @param onChanged    天气获取的结果回调
  void liveWeather({required String city, required OnLiveWeather onChanged}) async {
    this._onLiveWeather = onChanged;
    await methodChannel.invokeMethod('weatherSearch', {
      'city': city,
      'type': WeatherType.WEATHER_TYPE_LIVE.index,
    });
  }

  /// 获取预报天气数据
  ///
  /// @param city         获取指定城市的天气
  ///
  /// @param onChanged    天气获取的结果回调
  void forecastWeather({required String city, required OnForecastWeather onChanged}) async {
    this._onForecastWeather = onChanged;
    await methodChannel.invokeMethod('weatherSearch', {
      'city': city,
      'type': WeatherType.WEATHER_TYPE_FORECAST.index,
    });
  }
}
