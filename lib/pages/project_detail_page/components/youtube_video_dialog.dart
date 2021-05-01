import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:hackathon_panel/core/extension/context_extension.dart';

class YouTubeVideoDialog extends StatelessWidget {
  const YouTubeVideoDialog({
    required this.youtubePlayerController,
    Key? key,
  }) : super(key: key);

  final YoutubePlayerController youtubePlayerController;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Video'),
        content: SizedBox(
          width: context.width / 2,
          height: context.height / 2,
          child: YoutubePlayerControllerProvider(
            controller: youtubePlayerController,
            child: const YoutubePlayerIFrame(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async => Navigator.of(context).pop(),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Kapat'),
            ),
          ),
        ],
      );
}
