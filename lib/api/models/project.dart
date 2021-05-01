import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  Project({
    this.id,
    this.name,
    this.desc,
    this.teamName,
    this.liked,
    this.github,
    this.video,
    this.vote,
    this.images,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  int? id;
  String? name;
  String? desc;
  String? teamName;
  bool? liked;
  String? github;
  String? video;
  int? vote;
  dynamic images;

  Project fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
