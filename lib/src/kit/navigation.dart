import 'package:amap_kit/amap_kit.dart';
import 'kit.dart';

class NavigationKit implements Kit {
  @override
  void handlerData(int bid, data) {}

  /// 本机地图安装检查
  Future<NativeMaps> checkNativeMaps() async {
    final result = await methodChannel.invokeMethod('checkNativeMaps');
    return result != null ? NativeMaps.fromJson(Map.castFrom(result)) : NativeMaps();
  }

  /// 启动高德导航
  ///
  /// @param src 调起应用包名
  ///
  /// @param target 目的地坐标
  void amapNav({required String src, required LatLng target}) async {
    await methodChannel.invokeMethod('amapNav', {"src": src, "lat": target.lat, "lon": target.lng});
  }

  /// 启动百度导航
  void bmapNav({required String ak, required String mcode, required String src, required LatLng target}) async {
    final baiduTarget = await target.convertToBaidu(ak, mcode);
    if (baiduTarget != null)
      await methodChannel.invokeMethod('bmapNav', {
        "src": src,
        "location": '${baiduTarget.lat},${baiduTarget.lng}',
      });
  }
}
