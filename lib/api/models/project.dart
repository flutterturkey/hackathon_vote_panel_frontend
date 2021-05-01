class Project {
  Project({
    this.id,
    this.name,
    this.desc,
    this.teamName,
    this.liked,
    this.github,
    this.video,
    this.vote,
    this.images,
  });

  int? id;
  String? name;
  String? desc;
  String? teamName;
  bool? liked;
  String? github;
  String? video;
  int? vote;
  dynamic images;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
        teamName: json["team_name"],
        liked: json["liked"],
        github: json["github"],
        video: json["video"],
        vote: json["vote"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "team_name": teamName,
        "liked": liked,
        "github": github,
        "video": video,
        "vote": vote,
        "images": images,
      };
}
