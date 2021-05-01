// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.data,
    this.error,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json['message'],
        token: json['token'],
      );

  String? message;
  String? token;

  Map<String, dynamic> toJson() => {
        'message': message,
        'token': token,
      };
}
