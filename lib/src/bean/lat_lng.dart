import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'lat_lng.g.dart';

/// lng 经度
///
/// lat 纬度
@JsonSerializable()
class LatLng {
  final double lng;
  final double lat;

  const LatLng({required this.lng, required this.lat});

  factory LatLng.fromJson(Map<String, dynamic> srcJson) => _$LatLngFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return (other is LatLng) ? hashCode == other.hashCode : false;
  }

  @override
  int get hashCode => '$lat,$lng'.hashCode;
}

/// 常用坐标系
///
/// + [aliyun]  阿里云
/// + [baidu]   百度坐标
/// + [google]  谷歌坐标
/// + [gps]     gps原始坐标
/// + [mapabc]  图盟坐标
/// + [mapbar]  图吧坐标
/// + [sosomap]  搜搜坐标
enum CoordType { baidu, mapbar, mapabc, sosomap, aliyun, google, gps }

extension LatLngExt on LatLng {
  /// 将高德坐标转为百度bd09ll坐标
  Future<LatLng?> convertToBaidu(String ak, String mcode) async {
    var client = HttpClient();
    final url = 'http://api.map.baidu.com/geoconv/v1/?coords=$lng,$lat&from=3&to=5&ak=$ak&mcode=$mcode';
    var request = await client.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var result = await response.transform(utf8.decoder).join();
      var resultMap = json.decode(result);
      if (resultMap['status'] == 0) {
        var first = (resultMap['result'] as List).first;
        return LatLng(lng: first['x'], lat: first['y']);
      }
    }
    return null;
  }
}
