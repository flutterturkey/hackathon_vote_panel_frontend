// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    id: json['id'] as int?,
    name: json['name'] as String?,
    desc: json['desc'] as String?,
    teamName: json['teamName'] as String?,
    liked: json['liked'] as bool?,
    github: json['github'] as String?,
    video: json['video'] as String?,
    images:
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'teamName': instance.teamName,
      'liked': instance.liked,
      'github': instance.github,
      'video': instance.video,
      'images': instance.images,
    };
