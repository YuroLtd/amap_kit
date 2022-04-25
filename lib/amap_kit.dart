library amap_kit;

import 'package:flutter/services.dart';
import 'src/bean/bean.dart';
import 'src/kits/kit.dart';
import 'src/util/util.dart';

export 'src/bean/bean.dart';

class AmapKit {
  static const _methodChannel = MethodChannel('plugin.yuro.com/amap_kit.method');
  static const _eventChannel = EventChannel('plugin.yuro.com/amap_kit.event');

  static AmapKit? _amapKit;

  factory AmapKit() => _amapKit ??= AmapKit._();

  static final Map<Kid, Kit> _kits = {};

  AmapKit._() {
    _eventChannel
        .receiveBroadcastStream()
        .asBroadcastStream()
        .map((event) => EventSink.fromJson(Map.castFrom(event)..deepCast()))
        .listen((eventSink) => _kits[eventSink.kid]?.handlerData(eventSink.bid, eventSink.code, eventSink.data))
        // ignore: avoid_print
        .onError((err) => print(err));
  }

  bool _initialized = false;

  bool get initialized => _initialized;

  /// 设置地图ApiKey
  ///
  /// + [android]     Android端地图apiKey
  /// + [ios]         IOS端地图apiKey
  /// + [isContains]  是隐私权政策是否包含高德开平隐私权政策  true-已包含
  /// + [isShow]      隐私权政策是否弹窗展示告知用户 true-已展示
  /// + [isAgree]     隐私权政策是否取得用户同意  true-用户已同意
  ///
  /// Return bool     是否初始化完成
  Future<bool> setApiKey({
    required String android,
    required String ios,
    bool isContains = true,
    bool isShow = true,
    bool isAgree = true,
  }) async {
    if (!_initialized) {
      final result = await _methodChannel.invokeMethod<bool>('setApiKey', {
        'android': android,
        'ios': ios,
        'isContains': isContains,
        'isShow': isShow,
        'isAgree': isAgree,
      });
      _initialized = result ?? false;
    }
    return _initialized;
  }

  /// 工具
  ToolKit get tool => _kits.putIfAbsent(Kid.tool, () => ToolKit(_methodChannel)) as ToolKit;

  /// 定位
  LocationKit get location => _kits.putIfAbsent(Kid.location, () => LocationKit(_methodChannel)) as LocationKit;

  /// 搜索
  SearchKit get search => _kits.putIfAbsent(Kid.search, () => SearchKit(_methodChannel)) as SearchKit;

  /// 导航
  NavigateKit get navigate => _kits.putIfAbsent(Kid.navigate, () => NavigateKit(_methodChannel)) as NavigateKit;
}
