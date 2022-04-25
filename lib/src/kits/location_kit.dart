import 'package:amap_kit/src/bean/bean.dart';
import 'package:flutter/services.dart';

import 'kit.dart';

typedef OnLocationChanged = void Function(int errorCode, Location? location);

class LocationKit extends Kit {
  LocationKit(MethodChannel methodChannel) : super(methodChannel);

  final _funcMap = <int, OnLocationChanged>{};

  @override
  void handlerData(Bid bid, int code, data) {
    if (bid == Bid.location) {
      if (code == 0) {
        final location = Location.fromJson(Map.castFrom(data));
        _funcMap[location.locationId]?.call(0, location);
      } else {
        _funcMap[data as int]?.call(code, null);
      }
    }
  }

  /// 开始定位
  ///
  /// + [options]   定位参数
  /// + [onChanged] 定位结果回调
  Future<int> startLocation({required OnLocationChanged onChanged, LocationOptions? locationOptions}) async {
    final options = locationOptions ?? LocationOptions();
    await methodChannel.invokeMethod('startLocation', options.toMap());
    _funcMap[options.locationId] = onChanged;
    return options.locationId;
  }

  /// 停止定位
  ///
  /// + [locationId] 定位id,启动定位时的返回
  void stopLocation(int locationId) async {
    await methodChannel.invokeMethod('stopLocation', {'locationId': locationId});
    _funcMap.remove(locationId);
  }
}
