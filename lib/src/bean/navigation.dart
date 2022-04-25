import 'package:json_annotation/json_annotation.dart';

part 'navigation.g.dart';

@JsonSerializable()
class NativeMaps extends Object {
  final bool amap;

  final bool bmap;

  NativeMaps({this.amap = false, this.bmap = false});

  factory NativeMaps.fromJson(Map<String, dynamic> srcJson) => _$NativeMapsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NativeMapsToJson(this);
}
