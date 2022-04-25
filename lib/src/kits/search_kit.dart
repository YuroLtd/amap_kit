import 'package:amap_kit/src/bean/bean.dart';
import 'package:amap_kit/src/util/util.dart';
import 'package:flutter/services.dart';

import 'kit.dart';

typedef OnLiveWeather = void Function(LiveWeather liveWeather);
typedef OnForecastWeather = void Function(ForecastWeather forecastWeather);

class SearchKit extends Kit {
  SearchKit(MethodChannel methodChannel) : super(methodChannel);

  OnLiveWeather? _onLiveWeather;
  OnForecastWeather? _onForecastWeather;

  @override
  void handlerData(Bid bid, int code, data) {
    if (bid == Bid.weatherLive) {
      _onLiveWeather?.call(LiveWeather.fromJson(Map.castFrom(data)));
    } else if (bid == Bid.weatherForecast) {
      _onForecastWeather?.call(ForecastWeather.fromJson(Map.castFrom(data)..deepCast()));
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
