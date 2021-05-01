import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  BaseResponse({
    this.data,
    this.error,
  });

  Data? data;
  bool? error;

  BaseResponse fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  String? message;

  Data fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
