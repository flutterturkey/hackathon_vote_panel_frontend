import 'package:flutter/material.dart';
import 'package:hackathon_panel/pages/splash_page.dart';

void main() {
  runApp(HackathonPanel());
}

class HackathonPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hackathon Oylama Paneli',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}
