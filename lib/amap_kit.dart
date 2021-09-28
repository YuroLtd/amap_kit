import 'package:flutter/services.dart';
import 'package:amap_kit/src/kit/kit.dart';
import 'package:amap_kit/src/bean/event_sink.dart';
import 'package:amap_kit/src/util/map_ext.dart';

export 'src/bean/bean.dart';

class AmapKit {
  static const _METHOD_CHANNEL = 'plugin.yuro.com/amap_kit.method';
  static const _EVENT_CHANNEL = 'plugin.yuro.com/amap_kit.event';

  static const MethodChannel methodChannel = const MethodChannel(_METHOD_CHANNEL);
  static const EventChannel _eventChannel = const EventChannel(_EVENT_CHANNEL);

  static AmapKit? _amapKit;
  static Map<Tid, Kit> _kitMap = {};

  AmapKit._() {
    _eventChannel
        .receiveBroadcastStream()
        .asBroadcastStream()
        .map<Map<String, dynamic>>((event) => Map<String, dynamic>.from(event))
        .listen(onData, onError: onError);
  }

  factory AmapKit() => _amapKit ??= AmapKit._();

  void onData(Map<String, dynamic> event) {
    final eventSink = EventSink.fromJson(event);
    _kitMap.where((k, v) => k == eventSink.tid).forEach((key, value) {
      value.handlerData(eventSink.bid, eventSink.data);
    });
  }

  void onError(err) => print(err);

  /// 定位
  LocationKit get location => _kitMap.putIfAbsent(Tid.LOCATION, () => LocationKit()) as LocationKit;

  /// 搜索
  SearchKit get search => _kitMap.putIfAbsent(Tid.SEARCH, () => SearchKit()) as SearchKit;

  /// 工具
  ToolKit get tool => _kitMap.putIfAbsent(Tid.TOOL, () => ToolKit()) as ToolKit;

  /// 导航
  NavigationKit get nav => _kitMap.putIfAbsent(Tid.NAVIGATION, () => NavigationKit()) as NavigationKit;
}
