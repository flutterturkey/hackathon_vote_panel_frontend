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
    vote: json['vote'] as int?,
    images: json['images'],
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
      'vote': instance.vote,
      'images': instance.images,
    };
