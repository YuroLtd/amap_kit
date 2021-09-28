/// 定位模式
///
/// Battery_Saving 低功耗模式
///
/// Device_Sensors 仅设备模式
///
/// Hight_Accuracy 高精度模式
enum LocationMode { Battery_Saving, Device_Sensors, Hight_Accuracy }

/// 定位场景
///
/// SignIn 签到场景
///
/// Transport 出行场景
///
/// Sport 运动场景
enum LocationPurpose { SignIn, Transport, Sport }

/// 设定网络定位时所采用的协议
enum LocationProtocol { HTTP, HTTPS }

/// ALIYUN   阿里云
///
/// BAIDU    百度坐标
///
/// GOOGLE   谷歌坐标
///
/// GPS      GPS原始坐标
///
/// MAPABC   图盟坐标
///
/// MAPBAR   图吧坐标
///
/// SOSOMAP   搜搜坐标
enum CoordType { BAIDU, MAPBAR, MAPABC, SOSOMAP, ALIYUN, GOOGLE, GPS }

/// WEATHER_TYPE_LIVE     实时天气
///
/// WEATHER_TYPE_FORECAST 预报天气
enum WeatherType { WEATHER_TYPE_LIVE, WEATHER_TYPE_FORECAST }

/// 地图类型
///
/// AMap 高德地图
///
/// BMap 百度地图
enum MapType { AMap, BMap }
