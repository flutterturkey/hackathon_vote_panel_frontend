// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectListResponse _$ProjectListResponseFromJson(Map<String, dynamic> json) {
  return ProjectListResponse(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
        .toList(),
    error: json['error'] as String?,
  );
}

Map<String, dynamic> _$ProjectListResponseToJson(
        ProjectListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
    };
