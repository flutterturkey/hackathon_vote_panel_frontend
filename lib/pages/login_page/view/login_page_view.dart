import 'dart:math';

import 'package:flutter/material.dart';

import 'package:hackathon_panel/core/base/base_view.dart';
import 'package:hackathon_panel/core/components/app_logo.dart';
import 'package:hackathon_panel/core/components/base_button.dart';
import 'package:hackathon_panel/core/extension/context_extension.dart';
import 'package:hackathon_panel/pages/login_page/components/email_input_field.dart';
import 'package:hackathon_panel/pages/login_page/components/password_input_field.dart';
import 'package:hackathon_panel/pages/login_page/viewmodel/login_page_view_model.dart';
import 'package:shimmer/shimmer.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  late LoginPageViewModel viewModel;

  @override
  Widget build(BuildContext context) => BaseView<LoginPageViewModel>(
        onModelReady: (model) {
          model
            ..init()
            ..setContext(context);
          viewModel = model;
        },
        model: LoginPageViewModel(),
        builder: (context, value) => Scaffold(
          key: viewModel.scaffoldKey,
          body: Form(
            autovalidateMode: viewModel.isAutoValidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            key: viewModel.loginFormKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(36),
              child: Center(
                child: AutofillGroup(
                  child: Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.blueAccent,
                        highlightColor: Colors.white,
                        period: const Duration(seconds: 2),
                        child: Text(
                          'Flutter Festivali Hackathon Paneline Hoş Geldiniz',
                          style: context.textTheme.headline4!
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const AppLogo(height: 250),
                      const SizedBox(height: 50),
                      EmailInputField(controller: viewModel.emailController),
                      PasswordInputField(
                        controller: viewModel.passwordController,
                      ),
                      const SizedBox(height: 30),
                      BaseButton(
                        label: 'Giriş Yap',
                        onPressed: () async => viewModel.onPressedLoginButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
