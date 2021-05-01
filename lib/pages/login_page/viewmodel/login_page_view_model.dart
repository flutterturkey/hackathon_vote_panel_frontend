import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:hackathon_panel/api/handler/api.dart';
import 'package:hackathon_panel/core/base/base_view_model.dart';
import 'package:hackathon_panel/core/util/token.dart';
import 'package:hackathon_panel/pages/home_page/view/home_page_view.dart';

part 'login_page_view_model.g.dart';

class LoginPageViewModel = _LoginPageViewModelBase with _$LoginPageViewModel;

abstract class _LoginPageViewModelBase with Store, BaseViewModel {
  late final GlobalKey<FormState> loginFormKey;
  late final GlobalKey<ScaffoldState> scaffoldKey;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @observable
  bool isAutoValidate = false;

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void init() {
    loginFormKey = GlobalKey<FormState>();
    scaffoldKey = GlobalKey();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @action
  Future<void> onPressedLoginButton() async {
    if (!checkForm()) {
      return;
    }
    await fetchLogin();
  }

  @action
  bool checkForm() {
    if (!loginFormKey.currentState!.validate()) {
      isAutoValidate = true;
      return false;
    }
    return true;
  }

  Future<void> fetchLogin() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Giriş yapılıyor...')),
    );

    logger.d(
      'email : ${emailController.text}\t'
      'password :  ${passwordController.text}',
    );

    final response = await API.login(
      emailController.text,
      passwordController.text,
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    if (response.data!.message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data!.message!)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Giriş başarılı!')),
      );
      await Utils.instance.setToken(response.data!.token!).then(
            (_) async => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomePageView()),
            ),
          );
    }
  }
}
