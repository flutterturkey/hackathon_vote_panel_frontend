import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:hackathon_panel/api/models/project_detail_response.dart';
import 'package:hackathon_panel/core/base/base_view.dart';
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
            title: Text(widget.projectName!),
            actions: [
              IconButton(
                icon: const Icon(MdiIcons.github),
                onPressed: () async {
                  if (await canLaunch(widget.github!)) {
                    await launch(widget.github!);
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: FutureBuilder<ProjectDetailResponse>(
              future: viewModel.getProjectDetail(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final item = snapshot.data!.data!;
                  const player = YoutubePlayerIFrame();
                  if (item.video!.contains('youtu')) {
                    viewModel.youtubePlayerController = YoutubePlayerController(
                      initialVideoId:
                          YoutubePlayerController.convertUrlToId(item.video!)!,
                      params: const YoutubePlayerParams(
                        showControls: true,
                        showFullscreenButton: false,
                        desktopMode: true,
                        privacyEnhanced: true,
                        useHybridComposition: true,
                      ),
                    );
                    viewModel.youtubePlayerController.onEnterFullscreen = () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                    };
                  }

                  return Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        Text(
                          item.desc!,
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Takım: ${item.teamName!}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(height: 32),
                        CarouselSlider.builder(
                          itemCount: item.images!.length,
                          itemBuilder: (context, index, i) =>
                              CachedNetworkImage(
                            imageUrl:
                                'https://cors.bridged.cc/${item.images![index]}',
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(MdiIcons.alertCircle),
                          ),
                          options: CarouselOptions(
                            height: 696,
                            aspectRatio: 16 / 9,
                            viewportFraction:
                                viewModel.calculateViewportFraction(
                                    MediaQuery.of(context).size.width),
                            initialPage: 0,
                            enableInfiniteScroll:
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                item.images!.length == 1 ? false : true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        if (item.video!.contains('youtu'))
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 2,
                            child: YoutubePlayerControllerProvider(
                              controller: viewModel.youtubePlayerController,
                              child: player,
                            ),
                          ),
                        if (!item.video!.contains('youtu'))
                          ElevatedButton(
                            onPressed: () async {
                              if (await canLaunch(item.video!)) {
                                await launch(item.video!);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blueAccent),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Video için tıklayınız',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      );
}
