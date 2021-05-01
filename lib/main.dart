import 'package:flutter/material.dart';
import 'package:hackathon_panel/pages/splash_page.dart';

void main() {
  runApp(
    const HackathonPanel(),
  );
}

class HackathonPanel extends StatelessWidget {
  const HackathonPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Hackathon Oylama Paneli',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashPage(),
      );
}
