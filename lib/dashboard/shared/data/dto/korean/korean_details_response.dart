class KoreanDetailsResponse {
  String? id;
  String? title;
  List<String>? otherNames;
  String? image;
  String? description;
  String? releaseDate;
  List<String>? genres;
  List<Episodes>? episodes;

  KoreanDetailsResponse(
      {this.id,
      this.title,
      this.otherNames,
      this.image,
      this.description,
      this.releaseDate,
      this.genres,
      this.episodes});

  KoreanDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    otherNames = json['otherNames']?.cast<String>();
    image = json['image'];
    description = json['description'];
    releaseDate = json['releaseDate'];
    genres = json['genres']?.cast<String>();
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(Episodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['otherNames'] = otherNames;
    data['image'] = image;
    data['description'] = description;
    data['releaseDate'] = releaseDate;
    data['genres'] = genres;
    if (episodes != null) {
      data['episodes'] = episodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Episodes {
  String? id;
  String? title;
  num? episode;
  String? subType;
  String? releaseDate;
  String? url;

  Episodes(
      {this.id,
      this.title,
      this.episode,
      this.subType,
      this.releaseDate,
      this.url});

  Episodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    episode = json['episode'];
    subType = json['subType'];
    releaseDate = json['releaseDate'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['episode'] = episode;
    data['subType'] = subType;
    data['releaseDate'] = releaseDate;
    data['url'] = url;
    return data;
  }
}
