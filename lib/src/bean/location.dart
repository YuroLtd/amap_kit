import 'package:amap_kit/amap_kit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

/// @param longitude 经度
///
/// @param latitude 纬度
///
/// @param accuracy 定位精度:米
///
/// @param altitude 海拔高度(单位：米)
///
/// @param address 地址信息
///
/// @param country 国家
///
/// @param province 省份
///
/// @param city 城市
///
/// @param district 区/县
///
/// @param street 街道
///
/// @param streetNum 门牌号
///
/// @param floor 楼层信息
///
/// @param cityCode 城市编码
///
/// @param adCode 区域编码
///
/// @param aoiName 当前位置所处AOI名称
///
/// @param poiName 当前位置POI名称
///
/// @param description 位置语义信息
///
/// @param speed 速度
///
/// @param bearing 方向角

@JsonSerializable()
class Location extends Object {
  double latitude;

  double longitude;

  double altitude;

  double accuracy;

  String address;

  String country;

  String province;

  String city;

  String district;

  String street;

  String streetNum;

  String floor;

  String cityCode;

  String adCode;

  String aoiName;

  String poiName;

  String description;

  double speed;

  double bearing;

  Location(
    this.latitude,
    this.longitude,
    this.altitude,
    this.accuracy,
    this.address,
    this.country,
    this.province,
    this.city,
    this.district,
    this.street,
    this.streetNum,
    this.floor,
    this.cityCode,
    this.adCode,
    this.aoiName,
    this.poiName,
    this.description,
    this.speed,
    this.bearing,
  );

  factory Location.fromJson(Map<String, dynamic> srcJson) => _$LocationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  LatLng get latLng => LatLng(lng: longitude, lat: latitude);
}
