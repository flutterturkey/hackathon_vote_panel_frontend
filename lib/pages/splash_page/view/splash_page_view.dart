import 'package:flutter/material.dart';

import 'package:hackathon_panel/core/base/base_view.dart';
import 'package:hackathon_panel/core/components/loading_indicator.dart';
import 'package:hackathon_panel/pages/splash_page/viewmodel/splash_page_view_model.dart';

class SplashPageView extends StatefulWidget {
  const SplashPageView({Key? key}) : super(key: key);
  @override
  _SplashPageViewState createState() => _SplashPageViewState();
}

class _SplashPageViewState extends State<SplashPageView> {
  late SplashPageViewModel viewModel;

  @override
  Widget build(BuildContext context) => BaseView<SplashPageViewModel>(
        onModelReady: (model) {
          model
            ..init()
            ..setContext(context);
          viewModel = model;
        },
        model: SplashPageViewModel(),
        builder: (context, value) => const Scaffold(
          backgroundColor: Colors.white,
          body: LoadingIndicator(),
        ),
      );
}
