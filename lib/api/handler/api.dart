import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hackathon_panel/api/models/base_response.dart';
import 'package:hackathon_panel/api/models/login_response.dart';
import 'package:hackathon_panel/api/models/project_detail_response.dart';
import 'package:hackathon_panel/api/models/project_list_response.dart';
import 'package:hackathon_panel/util/constants.dart';
import 'package:http/http.dart' as http;

// ignore: avoid_classes_with_only_static_members
class API {
  static const String apiUrl = 'hp-api.ademozcan.com.tr';

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${AppConstants.instance.token}'
  };

  static Future<dynamic> get(String path) async {
    final response = await http.get(handleUrl(path), headers: headers);
    return response.body;
  }

  static Future<dynamic> post(String path, {Map<String, String>? body}) async {
    final response = await http.post(
      handleUrl(path),
      headers: headers,
    );
    return response.body;
  }

  static Future<dynamic> delete(String path) async {
    final response = await http.delete(handleUrl(path), headers: headers);
    return response.body;
  }

  static Uri handleUrl(String path) => Uri.https(apiUrl, 'api/$path');

  static Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(
      handleUrl('login'),
      headers: headers,
      body: {
        'email': email,
        'password': password,
      },
    );

    return LoginResponse().fromJson(json.decode(response.body));
  }

  static Future<ProjectListResponse> getProjects() async {
    final response = await get('projects');
    return ProjectListResponse().fromJson(json.decode(response));
  }

  static Future<ProjectDetailResponse> getProjectDetail(int id) async {
    final response = await get('projects/$id');
    return ProjectDetailResponse().fromJson(json.decode(response));
  }

  static Future<BaseResponse> upvoteProject(int id) async {
    final response = await post('projects/$id');
    return BaseResponse().fromJson(json.decode(response));
  }

  static Future<BaseResponse> downvoteProject(int id) async {
    final response = await delete('projects/$id');
    return BaseResponse().fromJson(json.decode(response));
  }
}
