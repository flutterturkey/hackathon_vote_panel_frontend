// To parse this JSON data, do
//
//     final baseResponse = baseResponseFromJson(jsonString);

import 'dart:convert';

BaseResponse baseResponseFromJson(String str) =>
    BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  BaseResponse({
    this.data,
    this.error,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        data: Data.fromJson(json['data']),
        error: json['error'],
      );

  Data? data;
  bool? error;

  Map<String, dynamic> toJson() => {
        'data': data!.toJson(),
        'error': error,
      };
}

class Data {
  Data({
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json['message'],
      );

  String? message;

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
