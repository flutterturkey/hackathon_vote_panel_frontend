import 'package:flutter/material.dart';

import 'package:hackathon_panel/api/models/project_list_response.dart';
import 'package:hackathon_panel/core/base/base_view.dart';
import 'package:hackathon_panel/core/components/base_app_bar_title.dart';
import 'package:hackathon_panel/core/components/loading_indicator.dart';
import 'package:hackathon_panel/core/extension/context_extension.dart';
import 'package:hackathon_panel/pages/home_page/components/project_card.dart';
import 'package:hackathon_panel/pages/home_page/components/log_out_action_button.dart';
import 'package:hackathon_panel/pages/home_page/viewmodel/home_page_view_model.dart';

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
          appBar: AppBar(
            centerTitle: true,
            title: const AppBarTitle("Hackathon'a Katılan Projeler"),
            actions: [
              LogOutActionButton(
                onPressed: () async => viewModel.onPressedLogoutButton(),
              ),
            ],
          ),
          body: FutureBuilder<ProjectListResponse>(
            future: viewModel.getProjects(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(12),
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        viewModel.calculateCrossAxisCount(context.width),
                    childAspectRatio:
                        viewModel.calculateAspectRatio(context.width),
                  ),
                  itemBuilder: (context, index) {
                    final item = snapshot.data!.data![index];
                    return ProjectCard(
                      projectName: item.name!,
                      projectTeam: item.teamName!,
                      onPressedCard: () => viewModel.onPressedProjectCard(item),
                    );
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
