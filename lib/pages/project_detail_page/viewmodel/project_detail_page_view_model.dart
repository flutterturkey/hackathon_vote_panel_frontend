import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:hackathon_panel/api/handler/api.dart';
import 'package:hackathon_panel/api/models/project_detail_response.dart';
import 'package:hackathon_panel/core/base/base_view_model.dart';
import 'package:hackathon_panel/pages/project_detail_page/components/youtube_video_dialog.dart';

part 'project_detail_page_view_model.g.dart';

class ProjectDetailPageViewModel = _ProjectDetailPageViewModelBase
    with _$ProjectDetailPageViewModel;

abstract class _ProjectDetailPageViewModelBase with Store, BaseViewModel {
  late YoutubePlayerController youtubePlayerController;
  late final int? projectId;

  late final String videoLink;
  late final bool isYouTubeVideo;

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  void init() {}

  void dispose() {
    youtubePlayerController.close();
  }

  Future<ProjectDetailResponse> getProjectDetail() async {
    final response = await API.getProjectDetail(projectId!);
    return response;
  }

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

  Future<void> onPressedYouTubeIconButton() async {
    if (isYouTubeVideo) {
      await showDialog(
        context: context,
        builder: (context) => YouTubeVideoDialog(
          youtubePlayerController: youtubePlayerController,
        ),
      );
    } else {
      if (await canLaunch(videoLink)) {
        await launch(videoLink);
      }
    }
  }

  Future<void> onPressedGitHubIconButton(String githubLink) async {
    if (await canLaunch(githubLink)) {
      await launch(githubLink);
    }
  }
}
