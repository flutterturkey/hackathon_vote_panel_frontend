// To parse this JSON data, do
//
//     final projectDetailResponse = projectDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:hackathon_panel/api/models/project.dart';

ProjectDetailResponse projectDetailResponseFromJson(String str) =>
    ProjectDetailResponse.fromJson(json.decode(str));

String projectDetailResponseToJson(ProjectDetailResponse data) =>
    json.encode(data.toJson());

class ProjectDetailResponse {
  ProjectDetailResponse({
    this.data,
    this.error,
  });

  Project data;
  String error;

  factory ProjectDetailResponse.fromJson(Map<String, dynamic> json) =>
      ProjectDetailResponse(
        data: Project.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "error": error,
      };
}
