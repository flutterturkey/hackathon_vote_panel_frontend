import 'package:flutter/material.dart';

import 'package:hackathon_panel/core/util/app_icons.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    required this.onPressedCard,
    required this.onPressedLike,
    required this.projectName,
    required this.projectTeam,
    required this.isLiked,
    Key? key,
  }) : super(key: key);

  final String projectName;
  final String projectTeam;
  final bool isLiked;
  final VoidCallback onPressedCard;
  final VoidCallback onPressedLike;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(4),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onPressedCard,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _CardTeamItem(
                        title: projectName,
                        icon: AppIcons.instance.repository,
                      ),
                      const SizedBox(height: 10),
                      _CardTeamItem(
                        title: projectTeam,
                        icon: AppIcons.instance.team,
                        isTitle: false,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_outline_rounded,
                      color: isLiked ? Colors.orange[800] : Colors.grey,
                    ),
                    onPressed: onPressedLike,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _CardTeamItem extends StatelessWidget {
  const _CardTeamItem({
    required this.title,
    required this.icon,
    this.isTitle = true,
    Key? key,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final bool isTitle;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(
            icon,
            color: isTitle ? Colors.white : Colors.white54,
          ),
          const SizedBox(width: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: isTitle
                ? Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold)
                : Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white54),
          ),
        ],
      );
}
