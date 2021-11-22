export 'location.dart';
export 'navigation.dart';
export 'search.dart';
export 'tool.dart';

import 'package:flutter/services.dart';

const _METHOD_CHANNEL = 'plugin.yuro.com/amap_kit.method';
const _EVENT_CHANNEL = 'plugin.yuro.com/amap_kit.event';

const MethodChannel methodChannel = MethodChannel(_METHOD_CHANNEL);
const EventChannel eventChannel = EventChannel(_EVENT_CHANNEL);

abstract class Kit {
  void handlerData(int bid, dynamic data);
}
