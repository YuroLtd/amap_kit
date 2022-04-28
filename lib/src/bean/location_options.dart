/// Android定位模式
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

///iOS中期望的定位精度
enum DesiredAccuracy {
  ///最高精度
  best,

  ///适用于导航场景的高精度
  bestForNavigation,

  ///10米
  nearestTenMeters,

  ///100米
  hundredMeters,

  ///1000米
  kilometer,

  ///3000米
  threeKilometers,
}

///iOS 14中期望的定位精度,只有在iOS 14的设备上才能生效
enum AccuracyAuthorizationMode {
  ///精确和模糊定位
  fullAndReduceAccuracy,

  ///精确定位
  fullAccuracy,

  ///模糊定位
  reduceAccuracy
}

/// 定位设置
/// + [isOnceLocation] 是否单次单次定位
/// + [isNeedAddress] 是否需要地址信息
///
/// android
/// + [locationMode] 定位模式
/// + [locationPurpose] 定位场景
/// + [isOnceLocationLatest] 返回最近3s内精度最高的一次定位结果
/// + [interval] 定位请求的时间间隔,单位毫秒
/// + [isMockEnable] 是否允许模拟位置
/// + [httpTimeOut] 联网超时时间,单位毫秒
/// + [isLocationCacheEnable] 是否使用缓存策略
/// + [locationProtocol] 定位协议
/// + [isWifiScan] 是否允许主动调用WIFI刷新
///
/// ios
/// + [desiredAccuracy] 期望定位精度
/// + [pausesLocationUpdates] 允许系统暂停定位
/// + [distanceFilter] 定位最小更新距离
/// + [authorizationMode] 期望定位精度(ios 14及以上)
/// + [fullAccuracyPurposeKey] iOS 14中定位精度权限由模糊定位升级到精确定位时，需要用到的场景key fullAccuracyPurposeKey 这个key要和plist中的配置一样
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
  final DesiredAccuracy? desiredAccuracy;
  final bool? pausesLocationUpdates;
  final double? distanceFilter;
  final AccuracyAuthorizationMode? authorizationMode;
  final String fullAccuracyPurposeKey;

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
    this.desiredAccuracy,
    this.pausesLocationUpdates,
    this.distanceFilter,
    this.authorizationMode,
    this.fullAccuracyPurposeKey = '',
  }) : locationId = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'locationId': locationId,
        'isOnceLocation': isOnceLocation,
        'isNeedAddress': isNeedAddress,
        //
        'locationMode': locationMode?.index,
        'locationPurpose': locationPurpose?.index,
        'isOnceLocationLatest': isOnceLocationLatest,
        'interval': interval,
        'isMockEnable': isMockEnable,
        'httpTimeOut': httpTimeOut,
        'isLocationCacheEnable': isLocationCacheEnable,
        'locationProtocol': locationProtocol?.index,
        'isWifiScan': isWifiScan,
        //
        'desiredAccuracy': desiredAccuracy?.index,
        'pausesLocationUpdates': pausesLocationUpdates,
        'distanceFilter': distanceFilter,
        'authorizationMode': authorizationMode?.index,
        'fullAccuracyPurposeKey': fullAccuracyPurposeKey,
      };
}
