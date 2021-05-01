import 'package:flutter/material.dart';

import 'package:hackathon_panel/pages/home_page/view/home_page_view.dart';
import 'package:hackathon_panel/pages/login_page/view/login_page_view.dart';
import 'package:hackathon_panel/core/util/token.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) => const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
