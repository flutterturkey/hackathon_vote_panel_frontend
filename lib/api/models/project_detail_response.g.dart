// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectDetailResponse _$ProjectDetailResponseFromJson(
    Map<String, dynamic> json) {
  return ProjectDetailResponse(
    data: json['data'] == null
        ? null
        : Project.fromJson(json['data'] as Map<String, dynamic>),
    error: json['error'] as String?,
  );
}

Map<String, dynamic> _$ProjectDetailResponseToJson(
        ProjectDetailResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
    };
