import 'package:flutter/material.dart';
import 'package:hackathon_panel/api/handler/api.dart';
import 'package:hackathon_panel/api/models/project_list_response.dart';
import 'package:hackathon_panel/widgets/project_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ProjectListResponse> getProjects() async {
    return API.getProjects();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Projeler'),
      ),
      body: FutureBuilder<ProjectListResponse>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: calculateCrossAxisCount(screenSize.width),
                childAspectRatio: calculateAscpectRatio(screenSize.width),
              ),
              itemBuilder: (context, index) {
                final item = snapshot.data.data[index];
                return ProjectCard(item);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        future: getProjects(),
      ),
    );
  }

  double calculateAscpectRatio(double width) {
    var ratio = 0.0;
    if (width >= 1200) {
      ratio = (width / 3) / 144;
    } else if (width >= 1000) {
      ratio = width / 220;
    } else {
      ratio = width / 144;
    }

    return ratio;
  }

  int calculateCrossAxisCount(double width) {
    var crossAxisCount = 0;
    if (width >= 1200) {
      crossAxisCount = 3;
    } else if (width >= 1000) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return crossAxisCount;
  }
}
