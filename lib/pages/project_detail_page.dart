import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_panel/api/handler/api.dart';
import 'package:hackathon_panel/api/models/project_detail_response.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage(
    this.projectId,
    this.github,
    this.projectName, {
    Key? key,
  }) : super(key: key);

  final String? projectName;
  final String? github;
  final int? projectId;

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    getProjectDetail();
  }

  Future<ProjectDetailResponse> getProjectDetail() async {
    final response = await API.getProjectDetail(widget.projectId!);

    return response;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
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
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final item = snapshot.data!.data!;
                const player = YoutubePlayerIFrame();
                if (item.video!.contains('youtu')) {
                  _controller = YoutubePlayerController(
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
                  _controller.onEnterFullscreen = () {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ]);
                  };
                }

                return Expanded(
                  child: Column(
                    children: [
                      Text(item.teamName!),
                      Text(item.desc!),
                      const SizedBox(
                        height: 30,
                      ),
                      CarouselSlider.builder(
                        itemCount: item.images!.length,
                        itemBuilder: (context, index, i) => CachedNetworkImage(
                          imageUrl:
                              'https://cors.bridged.cc/${item.images![index]}',
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(MdiIcons.alertCircle),
                        ),
                        options: CarouselOptions(
                          height: 696,
                          aspectRatio: 16 / 9,
                          viewportFraction: calculateViewportFraction(
                              MediaQuery.of(context).size.width),
                          initialPage: 0,
                          enableInfiniteScroll: true,
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
                        height: 30,
                      ),
                      if (item.video!.contains('youtu'))
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 2,
                          child: YoutubePlayerControllerProvider(
                            controller: _controller,
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
                        height: 30,
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            future: getProjectDetail(),
          ),
        ),
      );

  double calculateViewportFraction(double width) {
    var viewportFraction = 0.0;
    if (width >= 1600) {
      viewportFraction = 0.25;
    } else if (width >= 1400) {
      viewportFraction = 0.3;
    } else if (width >= 1200) {
      viewportFraction = 0.4;
    } else if (width >= 1000) {
      viewportFraction = 0.5;
    } else {
      viewportFraction = 1;
    }

    return viewportFraction;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
