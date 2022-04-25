import 'package:json_annotation/json_annotation.dart';

part 'event_sink.g.dart';

/// 业务分类
enum Kid {
  /// 定位功能
  @JsonValue(10)
  location,

  /// 搜索功能
  @JsonValue(20)
  search,

  /// 导航功能
  @JsonValue(30)
  navigate,

  /// 工具类
  @JsonValue(40)
  tool,
}

/// 业务id
enum Bid {
  /// 定位数据
  @JsonValue(11)
  location,

  /// 实时天气
  @JsonValue(21)
  weatherLive,

  /// 预报天气
  @JsonValue(22)
  weatherForecast,
}

@JsonSerializable()
class EventSink extends Object {
  @JsonKey(name: 'kid')
  Kid kid;

  @JsonKey(name: 'bid')
  Bid bid;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  dynamic data;

  EventSink(
    this.kid,
    this.bid,
    this.code,
    this.data,
  );

  factory EventSink.fromJson(Map<String, dynamic> srcJson) => _$EventSinkFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EventSinkToJson(this);
}
