import 'package:amap_kit/amap_kit.dart';
import 'kit.dart';

class ToolKit implements Kit {
  @override
  void handlerData(int bid, data) {}

  /// 设置地图ApiKey
  ///
  /// + [androidKey]  Android端地图apiKey
  /// + [iosKey]      IOS端地图apiKey
  /// + [isContains]  是隐私权政策是否包含高德开平隐私权政策  true是包含
  /// + [isShow]      隐私权政策是否弹窗展示告知用户 true是展示
  /// + [isAgree]     隐私权政策是否取得用户同意  true是用户同意
  void setApiKey(
    String androidKey,
    String iosKey, {
    bool isContains = true,
    bool isShow = true,
    bool isAgree = true,
  }) async {
    await AmapKit.methodChannel.invokeMethod('setApiKey', {
      'androidKey': androidKey,
      'iosKey': iosKey,
      'isContains': isContains,
      'isShow': isShow,
      'isAgree': isAgree,
    });
  }

  /// 计算两点间距离 单位：米
  Future<double?> calculateLineDistance(LatLng ll1, LatLng ll2) async {
    return await AmapKit.methodChannel.invokeMethod('calculateLineDistance', {
      'll1': ll1.toJson(),
      'll2': ll2.toJson(),
    });
  }

  /// 坐标系转换
  Future<LatLng?> coordinateConvert(LatLng source, CoordType from) async {
    var result = await AmapKit.methodChannel.invokeMethod<Map<String, double>>('coordinateConvert', {
      'source': source.toJson(),
      'from': from.index,
    });
    return result != null ? LatLng.fromJson(result) : null;
  }
}
