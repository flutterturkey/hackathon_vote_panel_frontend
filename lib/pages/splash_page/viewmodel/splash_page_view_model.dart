import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:hackathon_panel/core/base/base_view_model.dart';
import 'package:hackathon_panel/core/util/token.dart';
import 'package:hackathon_panel/pages/home_page/view/home_page_view.dart';
import 'package:hackathon_panel/pages/login_page/view/login_page_view.dart';

part 'splash_page_view_model.g.dart';

class SplashPageViewModel = _SplashPageViewModelBase with _$SplashPageViewModel;

abstract class _SplashPageViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  Future<void> init() async {
    await checkToken();
  }

  Future<void> checkToken() async {
    final token = await Utils.instance.getToken();
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          if (token.isEmpty) {
            return const LoginPageView();
          } else {
            return const HomePageView();
          }
        },
      ),
    );
  }
}
