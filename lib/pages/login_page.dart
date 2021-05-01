import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_panel/api/handler/api.dart';
import 'package:hackathon_panel/pages/home_page.dart';
import 'package:hackathon_panel/util/token.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            children: [
              //email field
              TextFormField(
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    EmailValidator.validate(email) ? null : "Geçersiz email",
              ),
              //password field
              TextFormField(
                controller: _passwordController,
                validator: (val) =>
                    val.isEmpty ? 'Şifre boş bırakılamaz' : null,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Giriş yapılıyor...')));
                    print(
                        _emailController.text + ' ' + _passwordController.text);
                    final response = await API.login(
                        _emailController.text, _passwordController.text);
                    if (response.data.message != null) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response.data.message)));
                    } else {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Giriş başarılı!')));
                      await Utils.setToken(response.data.token);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => HomePage()));
                    }
                  }
                },
                child: Text('Giriş'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
