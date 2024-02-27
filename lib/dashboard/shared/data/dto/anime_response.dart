class AnimeResponse {
  int? currentPage;
  bool? hasNextPage;
  List<Results>? results;

  AnimeResponse({this.currentPage, this.hasNextPage, this.results});

  AnimeResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    hasNextPage = json['hasNextPage'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['hasNextPage'] = this.hasNextPage;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  late String id;
  Title? title;
  String? image;
  String? imageHash;
  String? episodeTitle;
  Trailer? trailer;
  String? description;
  String? status;
  String? cover;
  String? coverHash;
  int? rating;
  int? releaseDate;
  String? color;
  List<String>? genres;
  int? totalEpisodes;
  int? duration;
  String? type;

  Results(
      {required this.id,
      this.title,
      this.image,
      this.imageHash,
      this.episodeTitle,
      this.trailer,
      this.description,
      this.status,
      this.cover,
      this.coverHash,
      this.rating,
      this.releaseDate,
      this.color,
      this.genres,
      this.totalEpisodes,
      this.duration,
      this.type});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    image = json['image'];
    imageHash = json['imageHash'];
    episodeTitle = json['episodeTitle'];
    trailer =
        json['trailer'] != null ? Trailer.fromJson(json['trailer']) : null;
    description = json['description'];
    status = json['status'];
    cover = json['cover'];
    coverHash = json['coverHash'];
    rating = json['rating'];
    releaseDate = json['releaseDate'];
    color = json['color'];
    genres = json['genres'] == null ? [] : json['genres'].cast<String>();
    totalEpisodes = json['totalEpisodes'];
    duration = json['duration'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    data['image'] = this.image;
    data['imageHash'] = this.imageHash;
    data['episodeTitle'] = this.episodeTitle;
    if (this.trailer != null) {
      data['trailer'] = this.trailer!.toJson();
    }
    data['description'] = this.description;
    data['status'] = this.status;
    data['cover'] = this.cover;
    data['coverHash'] = this.coverHash;
    data['rating'] = this.rating;
    data['releaseDate'] = this.releaseDate;
    data['color'] = this.color;
    data['genres'] = this.genres;
    data['totalEpisodes'] = this.totalEpisodes;
    data['duration'] = this.duration;
    data['type'] = this.type;
    return data;
  }
}

class Title {
  String? romaji;
  String? english;
  String? native;
  String? userPreferred;

  Title({this.romaji, this.english, this.native, this.userPreferred});

  Title.fromJson(Map<String, dynamic> json) {
    romaji = json['romaji'];
    english = json['english'];
    native = json['native'];
    userPreferred = json['userPreferred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['romaji'] = this.romaji;
    data['english'] = this.english;
    data['native'] = this.native;
    data['userPreferred'] = this.userPreferred;
    return data;
  }
}

class Trailer {
  String? id;
  String? site;
  String? thumbnail;
  String? thumbnailHash;

  Trailer({this.id, this.site, this.thumbnail, this.thumbnailHash});

  Trailer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    site = json['site'];
    thumbnail = json['thumbnail'];
    thumbnailHash = json['thumbnailHash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['site'] = this.site;
    data['thumbnail'] = this.thumbnail;
    data['thumbnailHash'] = this.thumbnailHash;
    return data;
  }
}
