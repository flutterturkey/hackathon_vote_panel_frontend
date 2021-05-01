import 'package:flutter/material.dart';

class ProjectDetailPage extends StatefulWidget {
  ProjectDetailPage(this.projectId, this.projectName, {Key? key})
      : super(key: key);

  final String? projectName;
  final int? projectId;

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectName!),
      ),
    );
  }
}
