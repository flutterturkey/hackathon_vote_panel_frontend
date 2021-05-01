import 'package:json_annotation/json_annotation.dart';

import 'package:hackathon_panel/api/models/project.dart';

part 'project_detail_response.g.dart';

@JsonSerializable()
class ProjectDetailResponse {
  ProjectDetailResponse({
    this.data,
    this.error,
  });

  Project? data;
  String? error;

  ProjectDetailResponse fromJson(Map<String, dynamic> json) =>
      _$ProjectDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDetailResponseToJson(this);
}
