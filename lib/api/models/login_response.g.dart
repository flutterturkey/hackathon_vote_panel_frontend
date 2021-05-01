// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    data: json['data'] == null
        ? null
        : LoginData.fromJson(json['data'] as Map<String, dynamic>),
    error: json['error'] as bool?,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) {
  return LoginData(
    message: json['message'] as String?,
    token: json['token'] as String?,
  );
}

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
    };
