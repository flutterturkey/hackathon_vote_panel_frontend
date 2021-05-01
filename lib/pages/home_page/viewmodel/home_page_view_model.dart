import 'package:flutter/material.dart';
import 'package:hackathon_panel/core/util/token.dart';
import 'package:hackathon_panel/pages/login_page/view/login_page_view.dart';
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
    response.data!.shuffle();
    return response;
  }

  double calculateAspectRatio(double width) {
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

  Future<void> logout() async {
    final response = await API.logout();
    logger.d(response);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response.data!.message!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );

    await Utils.instance.setToken('');
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginPageView()),
    );
  }
}
