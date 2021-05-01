import 'package:flutter/material.dart';

import 'package:hackathon_panel/api/models/project.dart';
import 'package:hackathon_panel/pages/project_detail_page.dart';
import 'package:shimmer/shimmer.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard(this.project, {Key? key}) : super(key: key);

  final Project project;

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProjectDetailPage(
                    widget.project.id,
                    widget.project.github,
                    widget.project.name,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.blueAccent,
                  highlightColor: Colors.white,
                  period: const Duration(seconds: 2),
                  child: Text(
                    widget.project.name!,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.project.teamName!,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
}
