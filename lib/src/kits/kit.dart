import 'package:amap_kit/src/bean/bean.dart';
import 'package:flutter/services.dart';

export 'tool_kit.dart';
export 'location_kit.dart';
export 'search_kit.dart';
export 'navigate_kit.dart';

abstract class Kit {
  final MethodChannel methodChannel;

  Kit(this.methodChannel);

  void handlerData(Bid bid, int code, dynamic data);
}
