import 'package:amap_kit/amap_kit.dart';
import 'kit.dart';

class ToolKit implements Kit {
  @override
  void handlerData(int bid, data) {}

  void setApiKey(String androidKey, String iosKey) async {
    await AmapKit.methodChannel.invokeMethod('setApiKey', {'androidKey': androidKey, 'iosKey': iosKey});
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
