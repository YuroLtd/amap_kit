import 'package:json_annotation/json_annotation.dart';
import 'bean.dart';

part 'location_options.g.dart';

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
