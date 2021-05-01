import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:hackathon_panel/core/base/base_view.dart';
import 'package:hackathon_panel/pages/login_page/viewmodel/login_page_view_model.dart';

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
          appBar: AppBar(title: const Text('Giriş Yap')),
          body: Form(
            key: viewModel.formKey,
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Column(
                children: [
                  //email field
                  TextFormField(
                    controller: viewModel.emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) => EmailValidator.validate(email!)
                        ? null
                        : 'Geçersiz email',
                  ),
                  //password field
                  TextFormField(
                    controller: viewModel.passwordController,
                    validator: (val) =>
                        val!.isEmpty ? 'Şifre boş bırakılamaz' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async => viewModel.onPressedLoginButton(),
                    child: const Text('Giriş'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
