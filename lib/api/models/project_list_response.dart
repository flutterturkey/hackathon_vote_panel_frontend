// To parse this JSON data, do
//
//     final projectListResponse = projectListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:hackathon_panel/api/models/project.dart';

ProjectListResponse projectListResponseFromJson(String str) =>
    ProjectListResponse.fromJson(json.decode(str));

String projectListResponseToJson(ProjectListResponse data) =>
    json.encode(data.toJson());

class ProjectListResponse {
  ProjectListResponse({
    this.data,
    this.error,
  });

  List<Project> data;
  String error;

  factory ProjectListResponse.fromJson(Map<String, dynamic> json) =>
      ProjectListResponse(
        data: List<Project>.from(json["data"].map((x) => Project.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}
