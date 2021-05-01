import 'package:flutter/material.dart';

import 'package:hackathon_panel/api/models/project_list_response.dart';
import 'package:hackathon_panel/core/base/base_view.dart';
import 'package:hackathon_panel/core/components/loading_indicator.dart';
import 'package:hackathon_panel/core/extension/context_extension.dart';
import 'package:hackathon_panel/pages/home_page/viewmodel/home_page_view_model.dart';
import 'package:hackathon_panel/widgets/project_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
            backgroundColor: const Color(0xff424242),
            title: Text(
              "Hackathon'a Katılan Projeler",
              style: context.textTheme.headline4!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextButton(
                  onPressed: () async {
                    await viewModel.logout();
                  },
                  child: Row(
                    children: [
                      Icon(MdiIcons.logout, color: Colors.orange[800]),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Çıkış Yap',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
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
                        viewModel.calculateCrossAxisCount(context.width),
                    childAspectRatio:
                        viewModel.calculateAspectRatio(context.width),
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
