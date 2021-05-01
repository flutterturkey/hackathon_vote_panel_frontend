import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:hackathon_panel/api/handler/api.dart';
import 'package:hackathon_panel/core/base/base_view_model.dart';
import 'package:hackathon_panel/core/util/token.dart';
import 'package:hackathon_panel/pages/home_page/view/home_page_view.dart';

part 'login_page_view_model.g.dart';

class LoginPageViewModel = _LoginPageViewModelBase with _$LoginPageViewModel;

abstract class _LoginPageViewModelBase with Store, BaseViewModel {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void init() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> onPressedLoginButton() async {
    if (formKey.currentState!.validate()) {
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

      if (response.data!.message != null) {
        // ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data!.message!)),
        );
      } else {
        // ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Giriş başarılı!')),
        );
        await Utils.instance.setToken(response.data!.token!);
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePageView()),
        );
      }
    }
  }
}
