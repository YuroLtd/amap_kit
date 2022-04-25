/// 定位模式
///
/// + [batterySaving] 低功耗模式
/// + [deviceSensors] 仅设备模式
/// + [hightAccuracy] 高精度模式
enum LocationMode { batterySaving, deviceSensors, hightAccuracy }

/// 定位场景
///
/// + [signIn] 签到场景
/// + [transport] 出行场景
/// + [sport] 运动场景
enum LocationPurpose { signIn, transport, sport }

/// 设定网络定位时所采用的协议
enum LocationProtocol { http, https }

/// 定位设置
///
/// + [locationMode] 定位模式
/// + [locationPurpose] 定位场景
/// + [isOnceLocation] 是否单次单次定位
/// + [isOnceLocationLatest] 返回最近3s内精度最高的一次定位结果
/// + [interval] 定位请求的时间间隔,单位毫秒
/// + [isNeedAddress] 是否需要地址信息
/// + [isMockEnable] 是否允许模拟位置
/// + [httpTimeOut] 联网超时时间,单位毫秒
/// + [isLocationCacheEnable] 是否使用缓存策略
/// + [locationProtocol] 定位协议
/// + [isWifiScan] 是否允许主动调用WIFI刷新
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
  final int locationId;

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
  }) : locationId = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'locationId': locationId,
        'locationMode': locationMode?.index,
        'locationPurpose': locationPurpose?.index,
        'isOnceLocation': isOnceLocation,
        'isOnceLocationLatest': isOnceLocationLatest,
        'interval': interval,
        'isNeedAddress': isNeedAddress,
        'isMockEnable': isMockEnable,
        'httpTimeOut': httpTimeOut,
        'isLocationCacheEnable': isLocationCacheEnable,
        'locationProtocol': locationProtocol?.index,
        'isWifiScan': isWifiScan,
      };
}
