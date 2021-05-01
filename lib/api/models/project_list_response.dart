import 'package:json_annotation/json_annotation.dart';

import 'package:hackathon_panel/api/models/project.dart';

part 'project_list_response.g.dart';

@JsonSerializable()
class ProjectListResponse {
  ProjectListResponse({
    this.data,
    this.error,
  });

  List<Project>? data;
  String? error;

  ProjectListResponse fromJson(Map<String, dynamic> json) =>
      _$ProjectListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectListResponseToJson(this);
}
