import 'package:amap_kit/amap_kit.dart';
import 'kit.dart';

typedef OnLocationChanged = void Function(Location location);

class LocationKit extends Kit {
  @override
  void handlerData(int bid, data) {
    _onChanged?.call(Location.fromJson(Map.castFrom(data)));
  }

  OnLocationChanged? _onChanged;

  /// 开始定位
  ///
  /// @param options           定位参数
  ///
  /// @param OnLocationChanged 定位结果回调
  void startLocation({required OnLocationChanged onChanged, LocationOptions? options}) async {
    this._onChanged = onChanged;
    await methodChannel.invokeMethod('startLocation', (options ?? LocationOptions()).toJson());
  }

  /// 停止定位
  ///
  /// @param locationId 定位id,启动定位时的返回
  void stopLocation() async {
    await methodChannel.invokeMethod('stopLocation');
    this._onChanged = null;
  }
}
