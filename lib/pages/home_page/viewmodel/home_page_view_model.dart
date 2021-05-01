import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:hackathon_panel/api/handler/api.dart';
import 'package:hackathon_panel/api/models/project_list_response.dart';
import 'package:hackathon_panel/core/base/base_view_model.dart';

part 'home_page_view_model.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void init() {}

  Future<ProjectListResponse> getProjects() async {
    final response = await API.getProjects();
    response.data!.sort((a, b) => a.vote!.compareTo(b.vote!));
    return response;
  }

  double calculateAscpectRatio(double width) {
    var ratio = 0.0;
    if (width >= 1200) {
      ratio = (width / 3) / 144;
    } else if (width >= 1000) {
      ratio = width / 220;
    } else {
      ratio = width / 144;
    }

    return ratio;
  }

  int calculateCrossAxisCount(double width) {
    var crossAxisCount = 0;
    if (width >= 1200) {
      crossAxisCount = 3;
    } else if (width >= 1000) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return crossAxisCount;
  }
}
