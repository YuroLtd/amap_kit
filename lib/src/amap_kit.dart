import 'dart:async';

import 'package:flutter/services.dart';

import 'bean/bean.dart';

abstract class AmapKit {
  static const _METHOD_CHANNEL = 'plugin.yuro.com/amap_kit.method';
  static const _EVENT_CHANNEL = 'plugin.yuro.com/amap_kit.event';

  static const MethodChannel methodChannel = const MethodChannel(_METHOD_CHANNEL);
  static const EventChannel _eventChannel = const EventChannel(_EVENT_CHANNEL);

  AmapKit(String type) {
    _eventChannel
        .receiveBroadcastStream()
        .asBroadcastStream()
        .map<Map<String, dynamic>>((event) => Map<String, dynamic>.from(event)..deepCast())
        .where((event) => event['type'] == type)
        .listen((data) => handlerData(Map<String, dynamic>.from(data['data'])), onError: handlerErr);
  }

  void handlerData(Map<String, dynamic> data);

  void handlerErr(err);

  static void setApiKey(String androidKey, String iosKey) async {
    await methodChannel.invokeMethod('setApiKey', {'androidKey': androidKey, 'iosKey': iosKey});
  }

  /// 计算两点间距离 单位：米
  static Future<double?> calculateLineDistance(LatLng ll1, LatLng ll2) async {
    return await methodChannel.invokeMethod('calculateLineDistance', {'ll1': ll1.toJson(), 'll2': ll2.toJson()});
  }

  /// 坐标系转换
  static Future<LatLng?> coordinateConvert(LatLng source, CoordType from) async {
    var result = await methodChannel.invokeMethod<Map<String, double>>('coordinateConvert', {
      'source': source.toJson(),
      'from': from.index,
    });
    if (result != null) return LatLng.fromJson(result);
  }
}

extension _MapExt on Map {
  void deepCast() {
    keys.forEach((key) {
      if (this[key] is Map) {
        this[key] = Map<String, dynamic>.from(this[key])..deepCast();
      }
    });
  }
}
