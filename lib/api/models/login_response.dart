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

  Data? data;
  bool? error;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        data: Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "error": error,
      };
}

class Data {
  Data({
    this.message,
    this.token,
  });

  String? message;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"] ?? null,
        token: json["token"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
      };
}
