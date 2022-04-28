import 'package:amap_kit/src/bean/bean.dart';
import 'package:flutter/services.dart';

import 'kit.dart';

class ToolKit extends Kit {
  ToolKit(MethodChannel methodChannel) : super(methodChannel);

  @override
  void handlerData(Bid bid, int code, data) {}

  /// 本机地图安装检查
  Future<NativeMaps> checkNativeMaps() async {
    final result = await methodChannel.invokeMethod('checkNativeMaps');
    return result != null ? NativeMaps.fromJson(Map.castFrom(result)) : NativeMaps();
  }

  /// 计算两点间直线距离 单位：米
  Future<double?> calculateLineDistance(LatLng ll1, LatLng ll2) => methodChannel.invokeMethod('calculateLineDistance', {
        'lat1': ll1.lat,
        'lon1': ll1.lng,
        'lat2': ll2.lat,
        'lon2': ll2.lng,
      });

  /// 坐标系转换
  Future<LatLng?> coordinateConvert(LatLng source, CoordType from) async {
    final result = await methodChannel.invokeMethod('coordinateConvert', {
      'lat': source.lat,
      'lon': source.lng,
      'from': from.index,
    });
    return result != null ? LatLng.fromJson(Map.castFrom(result)) : null;
  }
}
