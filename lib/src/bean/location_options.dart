import 'package:json_annotation/json_annotation.dart';
import 'bean.dart';

part 'location_options.g.dart';

/// @param locationMode 定位模式
///
/// @param locationPurpose 定位场景
///
/// @param isOnceLocation 是否单次单次定位
///
/// @param isOnceLocationLatest 返回最近3s内精度最高的一次定位结果
///
/// @param interval 定位请求的时间间隔,单位毫秒
///
/// @param isNeedAddress 是否需要地址信息
///
/// @param isMockEnable 是否允许模拟位置
///
/// @param httpTimeOut 联网超时时间,单位毫秒
///
/// @param isLocationCacheEnable 是否使用缓存策略
///
/// @param locationProtocol 定位协议
///
/// @param isWifiScan 是否允许主动调用WIFI刷新
@JsonSerializable()
class LocationOptions {
  final LocationMode? locationMode;
  final LocationPurpose? locationPurpose;
  final bool? isOnceLocation;
  final bool? isOnceLocationLatest;
  final int? interval;
  final bool? isNeedAddress;
  final bool? isMockEnable;
  final int? httpTimeOut;
  final bool? isLocationCacheEnable;
  final LocationProtocol? locationProtocol;
  final bool? isWifiScan;

  LocationOptions({
    this.locationMode,
    this.locationPurpose,
    this.isOnceLocation,
    this.isOnceLocationLatest,
    this.interval,
    this.isNeedAddress,
    this.isMockEnable,
    this.httpTimeOut,
    this.isLocationCacheEnable,
    this.locationProtocol,
    this.isWifiScan,
  });

  factory LocationOptions.fromJson(Map<String, dynamic> srcJson) => _$LocationOptionsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LocationOptionsToJson(this);
}
