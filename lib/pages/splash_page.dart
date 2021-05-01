import 'package:flutter/material.dart';

import 'package:hackathon_panel/pages/home_page.dart';
import 'package:hackathon_panel/pages/login_page.dart';
import 'package:hackathon_panel/util/token.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    final token = await Utils.instance.getToken();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          if (token.isEmpty) {
            return LoginPage();
          } else {
            return HomePage();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
