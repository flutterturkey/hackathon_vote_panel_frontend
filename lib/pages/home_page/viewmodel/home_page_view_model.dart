import 'package:flutter/material.dart';
import 'package:hackathon_panel/api/models/base_response.dart';
import 'package:hackathon_panel/api/models/project.dart';
import 'package:hackathon_panel/pages/project_detail_page/view/project_detail_page_view.dart';
import 'package:mobx/mobx.dart';

import 'package:hackathon_panel/api/handler/api.dart';
import 'package:hackathon_panel/core/base/base_view_model.dart';
import 'package:hackathon_panel/core/util/token.dart';
import 'package:hackathon_panel/pages/login_page/view/login_page_view.dart';

part 'home_page_view_model.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store, BaseViewModel {
  @observable
  List<Project> projects = [];

  @observable
  bool loadingProjects = false;

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void init() {
    loadProjects();
  }

  @action
  Future<void> loadProjects() async {
    if (loadingProjects) {
      return;
    }
    loadingProjects = true;
    final response = await API.getProjects();
    response.data!.shuffle();
    response.data!.sort((a, b) {
      if (b.liked!) {
        return 1;
      }
      return -1;
    });
    loadingProjects = false;
    projects = response.data!;
  }

  @action
  void resetProjects() {
    projects = [];
    loadProjects();
  }

  @action
  Future<void> handleClick(Project project) async {
    late BaseResponse response;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (project.liked!) {
      response = await API.downvoteProject(project.id!);
    } else {
      response = await API.upvoteProject(project.id!);
    }

    if (response.error!) {
      await showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text(
                  'Uyarı!',
                  style: TextStyle(color: Colors.redAccent),
                ),
                content: Text(response.data!.message!),
                actions: [
                  TextButton(
                    onPressed: () async => Navigator.of(context).pop(),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Tamam'),
                    ),
                  ),
                ],
              ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.data!.message!,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );

      resetProjects();
    }
  }

  Future<void> onPressedLogoutButton() async {
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

  Future<void> onPressedProjectCard(Project project) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProjectDetailPageView(
          project.id,
          project.github,
          project.name,
        ),
      ),
    );
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
}
