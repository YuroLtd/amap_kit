import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'lat_lng.g.dart';

/// longitude 经度
///
/// latitude 纬度
@JsonSerializable()
class LatLng {
  final double longitude;
  final double latitude;

  const LatLng(this.longitude, this.latitude);

  factory LatLng.fromJson(Map<String, dynamic> srcJson) => _$LatLngFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LatLngToJson(this);
}

extension LatLngExt on LatLng {
  /// 将高德坐标转为百度bd09ll坐标
  Future<LatLng?> convertToBaidu(String ak, String mcode) async {
    var client = HttpClient();
    final url = 'http://api.map.baidu.com/geoconv/v1/?coords=$longitude,$latitude&from=3&to=5&ak=$ak&mcode=$mcode';
    var request = await client.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var result = await response.transform(utf8.decoder).join();
      var resultMap = json.decode(result);
      if (resultMap['status'] == 0) {
        var first = (resultMap['result'] as List).first;
        return LatLng(first['x'], first['y']);
      }
    }
    return null;
  }
}
