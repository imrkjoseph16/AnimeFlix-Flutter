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
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['hasNextPage'] = hasNextPage;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['image'] = image;
    data['imageHash'] = imageHash;
    data['episodeTitle'] = episodeTitle;
    if (trailer != null) {
      data['trailer'] = trailer!.toJson();
    }
    data['description'] = description;
    data['status'] = status;
    data['cover'] = cover;
    data['coverHash'] = coverHash;
    data['rating'] = rating;
    data['releaseDate'] = releaseDate;
    data['color'] = color;
    data['genres'] = genres;
    data['totalEpisodes'] = totalEpisodes;
    data['duration'] = duration;
    data['type'] = type;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['romaji'] = romaji;
    data['english'] = english;
    data['native'] = native;
    data['userPreferred'] = userPreferred;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['site'] = site;
    data['thumbnail'] = thumbnail;
    data['thumbnailHash'] = thumbnailHash;
    return data;
  }
}
