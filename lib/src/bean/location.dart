import 'package:amap_kit/amap_kit.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bean.dart';

part 'location.g.dart';

/// 定位结果
///
/// + [longitude] 经度
/// + [latitude] 纬度
/// + [accuracy] 定位精度:米
/// + [altitude] 海拔高度(单位：米)
/// + [address] 地址信息
/// + [country] 国家
/// + [province] 省份
/// + [city] 城市
/// + [district] 区/县
/// + [street] 街道
/// + [streetNum] 门牌号
/// + [floor] 楼层信息
/// + [cityCode] 城市编码
/// + [adCode] 区域编码
/// + [aoiName] 当前位置所处AOI名称
/// + [poiName] 当前位置POI名称
/// + [description] 位置语义信息
/// + [speed] 速度
/// + [bearing] 方向角
@JsonSerializable()
class Location extends Object {
  final int locationId;

  final double latitude;

  final double longitude;

  final double altitude;

  final double accuracy;

  final String address;

  final String country;

  final String province;

  final String city;

  final String district;

  final String street;

  final String streetNum;

  final String floor;

  final String cityCode;

  final String adCode;

  final String aoiName;

  final String poiName;

  final String description;

  final double speed;

  final double bearing;

  Location(
    this.locationId,
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
