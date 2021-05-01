import 'package:flutter/material.dart';

import 'package:hackathon_panel/api/models/project_list_response.dart';
import 'package:hackathon_panel/core/base/base_view.dart';
import 'package:hackathon_panel/core/components/loading_indicator.dart';
import 'package:hackathon_panel/core/extension/context_extension.dart';
import 'package:hackathon_panel/pages/home_page/viewmodel/home_page_view_model.dart';
import 'package:hackathon_panel/widgets/project_card.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late HomePageViewModel viewModel;

  @override
  Widget build(BuildContext context) => BaseView<HomePageViewModel>(
        onModelReady: (model) {
          model
            ..init()
            ..setContext(context);
          viewModel = model;
        },
        model: HomePageViewModel(),
        builder: (context, value) => Scaffold(
          appBar: AppBar(title: const Text('Projeler')),
          body: FutureBuilder<ProjectListResponse>(
            future: viewModel.getProjects(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        viewModel.calculateCrossAxisCount(context.height),
                    childAspectRatio:
                        viewModel.calculateAscpectRatio(context.width),
                  ),
                  itemBuilder: (context, index) {
                    final item = snapshot.data!.data![index];
                    return ProjectCard(item);
                  },
                );
              } else {
                return const LoadingIndicator();
              }
            },
          ),
        ),
      );
}
