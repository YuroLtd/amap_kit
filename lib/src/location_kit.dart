
import 'package:amap_kit/amap_kit.dart';

import 'bean/location.dart';
import 'bean/location_options.dart';

typedef OnLocationChanged = void Function(Location? location, dynamic err);

class LocationKit extends AmapKit {
  LocationKit() : super('location');

  OnLocationChanged? _onChanged;

  @override
  void handlerData(Map<String, dynamic> data) {
    _onChanged?.call(Location.fromJson(data), null);
  }

  @override
  void handlerErr(err) {
    _onChanged?.call(null, err);
  }

  /// 开始定位
  ///
  /// @param OnLocationChanged 定位结果回调
  ///
  /// @param options           定位参数
  ///
  /// @return                  定位id,取消时需要传入
  Future<String?> startLocation(OnLocationChanged onChanged, {LocationOptions? options}) async {
    this._onChanged = onChanged;
    return await AmapKit.methodChannel.invokeMethod<String>('startLocation', {
      'locationId': DateTime.now().millisecondsSinceEpoch.toString(),
      'options': (options ?? LocationOptions()).toJson(),
    });
  }

  /// 停止定位
  ///
  /// @param locationId 定位id,启动定位时的返回
  void stopLocation(String locationId) async {
    this._onChanged = null;
    await AmapKit.methodChannel.invokeMethod<bool>('stopLocation', locationId);
  }
}
