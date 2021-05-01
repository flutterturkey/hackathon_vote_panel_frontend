import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:hackathon_panel/api/models/project_detail_response.dart';
import 'package:hackathon_panel/core/base/base_view.dart';
import 'package:hackathon_panel/core/components/base_app_bar_title.dart';
import 'package:hackathon_panel/core/components/base_card.dart';
import 'package:hackathon_panel/core/components/loading_indicator.dart';
import 'package:hackathon_panel/core/extension/context_extension.dart';
import 'package:hackathon_panel/core/util/app_icons.dart';
import 'package:hackathon_panel/pages/project_detail_page/viewmodel/project_detail_page_view_model.dart';

class ProjectDetailPageView extends StatefulWidget {
  const ProjectDetailPageView(
    this.projectId,
    this.github,
    this.projectName, {
    Key? key,
  }) : super(key: key);

  final String? projectName;
  final String? github;
  final int? projectId;

  @override
  _ProjectDetailPageViewState createState() => _ProjectDetailPageViewState();
}

class _ProjectDetailPageViewState extends State<ProjectDetailPageView> {
  late ProjectDetailPageViewModel viewModel;

  @override
  Widget build(BuildContext context) => BaseView<ProjectDetailPageViewModel>(
        onModelReady: (model) {
          model
            ..init()
            ..setContext(context);
          viewModel = model;
          viewModel.projectId = widget.projectId;
        },
        dispose: () => viewModel.dispose(),
        model: ProjectDetailPageViewModel(),
        builder: (context, value) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: AppBarTitle(widget.projectName!),
            actions: [
              IconButton(
                icon: Icon(AppIcons.instance.youtube),
                tooltip: 'YouTube',
                onPressed: viewModel.onPressedYouTubeIconButton,
              ),
              IconButton(
                icon: Icon(AppIcons.instance.github),
                tooltip: 'GitHub',
                onPressed: () async => viewModel.onPressedGitHubIconButton(
                  widget.github!,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            physics: const BouncingScrollPhysics(),
            child: FutureBuilder<ProjectDetailResponse>(
              future: viewModel.getProjectDetail(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final item = snapshot.data!.data!;
                  if (item.video!.contains('youtu')) {
                    viewModel
                      ..isYouTubeVideo = true
                      ..youtubePlayerController = YoutubePlayerController(
                        initialVideoId: YoutubePlayerController.convertUrlToId(
                            item.video!)!,
                        params: const YoutubePlayerParams(
                          showFullscreenButton: false,
                          desktopMode: true,
                          privacyEnhanced: true,
                        ),
                      )
                      ..youtubePlayerController.onEnterFullscreen = () {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeLeft,
                          DeviceOrientation.landscapeRight,
                        ]);
                      };
                  } else if (!item.video!.contains('youtu')) {
                    viewModel.videoLink = item.video!;
                  }
                  return Column(
                    children: [
                      _InfoCard(
                        teamName: item.teamName!,
                        projectInfo: item.desc!,
                      ),
                      const SizedBox(height: 12),
                      _PhotoCard(
                        images: item.images,
                        viewportFraction: viewModel.calculateViewportFraction(
                          context.width,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const LoadingIndicator();
                }
              },
            ),
          ),
        ),
      );
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.teamName,
    required this.projectInfo,
    Key? key,
  }) : super(key: key);

  final String teamName;
  final String projectInfo;

  @override
  Widget build(BuildContext context) => BaseCard(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: Text('Takım: $teamName'),
            subtitle: Text(
              projectInfo,
              textAlign: TextAlign.justify,
            ),
            leading: Icon(AppIcons.instance.repository),
            isThreeLine: true,
          ),
        ),
      );
}

class _PhotoCard extends StatelessWidget {
  const _PhotoCard({
    required this.images,
    required this.viewportFraction,
    Key? key,
  }) : super(key: key);

  final List<String>? images;
  final double viewportFraction;

  @override
  Widget build(BuildContext context) => BaseCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CarouselSlider.builder(
            itemCount: images!.length,
            itemBuilder: (context, index, i) => CachedNetworkImage(
              imageUrl: 'https://cors.bridged.cc/${images![index]}',
              placeholder: (context, url) => const LoadingIndicator(),
              errorWidget: (context, url, error) =>
                  Icon(AppIcons.instance.alert),
            ),
            options: CarouselOptions(
              height: 696,
              viewportFraction: viewportFraction,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
              enableInfiniteScroll: images!.length != 1,
            ),
          ),
        ),
      );
}
