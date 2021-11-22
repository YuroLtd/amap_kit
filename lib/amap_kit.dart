import 'package:amap_kit/src/bean/event_sink.dart';
import 'package:amap_kit/src/kit/kit.dart';
import 'package:amap_kit/src/util/map_ext.dart';
import 'package:flutter/foundation.dart';

export 'src/bean/bean.dart';

class AmapKit {
  static AmapKit? _amapKit;
  static Map<Tid, Kit> _kitMap = {};

  AmapKit._() {
    eventChannel
        .receiveBroadcastStream()
        .asBroadcastStream()
        .map<Map<String, dynamic>>((event) => Map<String, dynamic>.from(event))
        .listen(_onData, onError: _onError);
  }

  factory AmapKit() => _amapKit ??= AmapKit._();

  void _onData(Map<String, dynamic> event) {
    final eventSink = EventSink.fromJson(event);
    _kitMap.where((k, v) => k == eventSink.tid).forEach((key, value) {
      value.handlerData(eventSink.bid, eventSink.data);
    });
  }

  void _onError(err) => debugPrint(err);

  /// 是否已经初始化
  bool initialized = false;

  /// 定位
  LocationKit get location => _kitMap.putIfAbsent(Tid.LOCATION, () => LocationKit()) as LocationKit;

  /// 搜索
  SearchKit get search => _kitMap.putIfAbsent(Tid.SEARCH, () => SearchKit()) as SearchKit;

  /// 工具
  ToolKit get tool => _kitMap.putIfAbsent(Tid.TOOL, () => ToolKit()) as ToolKit;

  /// 导航
  NavigationKit get nav => _kitMap.putIfAbsent(Tid.NAVIGATION, () => NavigationKit()) as NavigationKit;
}
