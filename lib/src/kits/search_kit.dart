import 'package:amap_kit/src/bean/bean.dart';
import 'package:amap_kit/src/util/util.dart';
import 'package:flutter/services.dart';

import 'kit.dart';

typedef OnLiveWeather = void Function(int code, LiveWeather? liveWeather);
typedef OnForecastWeather = void Function(int code, ForecastWeather? forecastWeather);

class SearchKit extends Kit {
  SearchKit(MethodChannel methodChannel) : super(methodChannel);

  OnLiveWeather? _onLiveWeather;
  OnForecastWeather? _onForecastWeather;

  @override
  void handlerData(Bid bid, int code, data) {
    print(data);
    if (bid == Bid.weatherLive) {
      LiveWeather? liveWeather;
      if (code == 0) liveWeather = LiveWeather.fromJson(Map.castFrom(data));
      _onLiveWeather?.call(code, liveWeather);
    } else if (bid == Bid.weatherForecast) {
      ForecastWeather? forecastWeather;
      if (code == 0) forecastWeather = ForecastWeather.fromJson(Map.castFrom(data)..deepCast());
      _onForecastWeather?.call(code, forecastWeather);
    }
  }

  /// 获取实时天气数据
  ///
  /// + [city]         获取指定城市的天气
  /// + [onChanged]    天气获取的结果回调
  void liveWeather({required String city, required OnLiveWeather onChanged}) async {
    _onLiveWeather = onChanged;
    await methodChannel.invokeMethod('weatherSearch', {'city': city, 'type': 1});
  }

  /// 获取预报天气数据
  ///
  /// + [city]         获取指定城市的天气
  /// + [onChanged]    天气获取的结果回调
  void forecastWeather({required String city, required OnForecastWeather onChanged}) async {
    _onForecastWeather = onChanged;
    await methodChannel.invokeMethod('weatherSearch', {'city': city, 'type': 2});
  }
}
