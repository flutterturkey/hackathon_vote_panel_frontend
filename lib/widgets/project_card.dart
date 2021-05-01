import 'package:flutter/material.dart';

import 'package:hackathon_panel/api/models/project.dart';
import 'package:hackathon_panel/pages/project_detail_page.dart';

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
            child: Row(
              children: [
                Text(
                  widget.project.name!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
}
