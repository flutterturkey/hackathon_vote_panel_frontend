import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:hackathon_panel/api/handler/api.dart';
import 'package:hackathon_panel/api/models/project_detail_response.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage(
    this.projectId,
    this.projectName, {
    Key? key,
  }) : super(key: key);

  final String? projectName;
  final int? projectId;

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  void initState() {
    super.initState();
    getProjectDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<ProjectDetailResponse> getProjectDetail() async {
    final response = await API.getProjectDetail(widget.projectId!);
    return response;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.projectName!),
        ),
        body: FutureBuilder<ProjectDetailResponse>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final item = snapshot.data!.data!;
              return Column(
                children: [
                  Row(
                    children: [
                      Text(item.name!),
                      IconButton(
                        icon: const Icon(MdiIcons.github),
                        onPressed: () async {
                          if (await canLaunch(item.github!)) {
                            await launch(item.github!);
                          }
                        },
                      ),
                    ],
                  ),
                  Text(item.teamName!),
                  Text(item.desc!),
                  Expanded(
                    child: Swiper(
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl:
                              'https://cors.bridged.cc/${item.images![index]}',
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(MdiIcons.alertCircle),
                        );
                      },
                      autoplay: true,
                      itemCount: item.images!.length,
                      viewportFraction: calculateViewportFraction(
                        MediaQuery.of(context).size.width,
                      ),
                      scale: 0.9,
                      autoplayDelay: 2000,
                      autoplayDisableOnInteraction: true,
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
          future: getProjectDetail(),
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
}
