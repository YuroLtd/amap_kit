import 'package:json_annotation/json_annotation.dart';

part 'lat_lng.g.dart';

/// latitude 经度
///
/// longitude 纬度
@JsonSerializable()
class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);

  factory LatLng.fromJson(Map<String, dynamic> srcJson) => _$LatLngFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LatLngToJson(this);
}
