import 'package:flutter/material.dart';

import 'package:hackathon_panel/pages/splash_page/view/splash_page_view.dart';

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.orange[800],
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF000000),
          accentColor: Colors.orange[800],
          accentIconTheme: const IconThemeData(color: Colors.black),
          dividerColor: Colors.black54,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashPageView(),
      );
}
