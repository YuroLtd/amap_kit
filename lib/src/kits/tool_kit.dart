import 'package:amap_kit/src/bean/bean.dart';
import 'package:flutter/services.dart';

import 'kit.dart';

class ToolKit extends Kit {
  ToolKit(MethodChannel methodChannel) : super(methodChannel);

  @override
  void handlerData(Bid bid, int code, data) {}

  /// 计算两点间距离 单位：米
  Future<double?> calculateLineDistance(LatLng ll1, LatLng ll2) => methodChannel.invokeMethod('calculateLineDistance', {
        'll1': ll1.toJson(),
        'll2': ll2.toJson(),
      });

  /// 坐标系转换
  Future<LatLng?> coordinateConvert(LatLng source, CoordType from) async {
    final result = await methodChannel.invokeMethod<Map<String, double>>('coordinateConvert', {
      'source': source.toJson(),
      'from': from.index,
    });
    return result != null ? LatLng.fromJson(result) : null;
  }
}
