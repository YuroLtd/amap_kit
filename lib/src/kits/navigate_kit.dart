import 'package:amap_kit/src/bean/bean.dart';
import 'package:flutter/services.dart';

import 'kit.dart';

class NavigateKit extends Kit {
  NavigateKit(MethodChannel methodChannel) : super(methodChannel);

  @override
  void handlerData(Bid bid, int code, data) {}

  /// 本机地图安装检查
  Future<NativeMaps> checkNativeMaps() async {
    final result = await methodChannel.invokeMethod('checkNativeMaps');
    return result != null ? NativeMaps.fromJson(Map.castFrom(result)) : NativeMaps();
  }

  /// 启动高德导航
  ///
  /// + [src] 调起应用包名
  /// + [target] 目的地坐标
  void amapNav({required String src, required LatLng target}) async {
    await methodChannel.invokeMethod('amapNav', {"src": src, "lat": target.lat, "lon": target.lng});
  }

  /// 启动百度导航
  ///
  /// + [ak] 百度地图ak
  /// + [mcode] 百度地图mcode
  /// + [src] 调起应用包名
  /// + [target] 目的地坐标
  void bmapNav({required String ak, required String mcode, required String src, required LatLng target}) async {
    final baiduTarget = await target.convertToBaidu(ak, mcode);
    if (baiduTarget != null) {
      await methodChannel.invokeMethod('bmapNav', {
        "src": src,
        "location": '${baiduTarget.lat},${baiduTarget.lng}',
      });
    }
  }
}
