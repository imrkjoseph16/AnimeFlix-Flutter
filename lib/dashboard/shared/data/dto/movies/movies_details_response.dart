class MoviesDetailsResponse {
  String? id;
  String? title;
  String? episodeId;
  List<Translations>? translations;
  String? image;
  String? cover;
  List<Logos>? logos;
  String? type;
  num? rating;
  String? releaseDate;
  String? description;
  List<String>? genres;
  int? duration;
  List<String>? directors;
  List<String>? writers;
  List<String>? actors;
  Trailer? trailer;
  Mappings? mappings;
  List<Similar>? similar;
  List<Recommendations>? recommendations;
  int? totalEpisodes;
  int? totalSeasons;
  List<Seasons>? seasons;

  MoviesDetailsResponse({
    this.id,
    this.title,
    this.episodeId,
    this.translations,
    this.image,
    this.cover,
    this.logos,
    this.type,
    this.rating,
    this.releaseDate,
    this.description,
    this.genres,
    this.duration,
    this.directors,
    this.writers,
    this.actors,
    this.trailer,
    this.mappings,
    this.similar,
    this.recommendations,
    this.seasons,
    this.totalEpisodes,
    this.totalSeasons,
  });

  MoviesDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    episodeId = json['episodeId'];
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(Translations.fromJson(v));
      });
    }
    image = json['image'];
    cover = json['cover'];
    if (json['logos'] != null) {
      logos = <Logos>[];
      json['logos'].forEach((v) {
        logos!.add(Logos.fromJson(v));
      });
    }
    type = json['type'];
    rating = json['rating'];
    releaseDate = json['releaseDate'];
    description = json['description'];
    genres = json['genres'] == null ? [] : json['genres'].cast<String>();
    duration = json['duration'];
    totalEpisodes = json['totalEpisodes'];
    totalSeasons = json['totalSeasons'];
    directors = json['directors'] == null ? [] : json['directors'].cast<String>();
    writers = json['writers'] == null ? [] : json['writers'].cast<String>();
    actors = json['actors'] == null ? [] : json['actors'].cast<String>();
    trailer =
        json['trailer'] != null ? Trailer.fromJson(json['trailer']) : null;
    mappings =
        json['mappings'] != null ? Mappings.fromJson(json['mappings']) : null;
    if (json['similar'] != null) {
      similar = <Similar>[];
      json['similar'].forEach((v) {
        similar!.add(Similar.fromJson(v));
      });
    }
    if (json['recommendations'] != null) {
      recommendations = <Recommendations>[];
      json['recommendations'].forEach((v) {
        recommendations!.add(Recommendations.fromJson(v));
      });
    }

    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(Seasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['episodeId'] = episodeId;
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    data['cover'] = cover;
    if (logos != null) {
      data['logos'] = logos!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['rating'] = rating;
    data['releaseDate'] = releaseDate;
    data['description'] = description;
    data['genres'] = genres;
    data['duration'] = duration;
    data['totalEpisodes'] = totalEpisodes;
    data['totalSeasons'] = totalSeasons;
    data['directors'] = directors;
    data['writers'] = writers;
    data['actors'] = actors;
    if (trailer != null) {
      data['trailer'] = trailer!.toJson();
    }
    if (mappings != null) {
      data['mappings'] = mappings!.toJson();
    }
    if (similar != null) {
      data['similar'] = similar!.map((v) => v.toJson()).toList();
    }
    if (recommendations != null) {
      data['recommendations'] =
          recommendations!.map((v) => v.toJson()).toList();
    }
    if (seasons != null) {
      data['seasons'] = seasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  String? description;
  String? language;
  String? title;

  Translations({this.description, this.language, this.title});

  Translations.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    language = json['language'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['language'] = language;
    data['title'] = title;
    return data;
  }
}

class Logos {
  String? url;
  double? aspectRatio;
  int? width;

  Logos({this.url, this.aspectRatio, this.width});

  Logos.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    aspectRatio = json['aspectRatio'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['aspectRatio'] = aspectRatio;
    data['width'] = width;
    return data;
  }
}

class Trailer {
  String? id;
  String? site;
  String? url;

  Trailer({this.id, this.site, this.url});

  Trailer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    site = json['site'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['site'] = site;
    data['url'] = url;
    return data;
  }
}

class Mappings {
  String? imdb;
  int? tmdb;

  Mappings({this.imdb, this.tmdb});

  Mappings.fromJson(Map<String, dynamic> json) {
    imdb = json['imdb'];
    tmdb = json['tmdb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imdb'] = imdb;
    data['tmdb'] = tmdb;
    return data;
  }
}

class Similar {
  int? id;
  String? title;
  String? image;
  String? type;
  num? rating;
  String? releaseDate;

  Similar(
      {this.id,
      this.title,
      this.image,
      this.type,
      this.rating,
      this.releaseDate});

  Similar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    type = json['type'];
    rating = json['rating'];
    releaseDate = json['releaseDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['type'] = type;
    data['rating'] = rating;
    data['releaseDate'] = releaseDate;
    return data;
  }
}

class Recommendations {
  int? id;
  String? title;
  String? image;
  String? type;
  num? rating;
  String? releaseDate;

  Recommendations({this.id, this.title, this.image, this.rating, this.type});

  Recommendations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    rating = json['rating'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['rating'] = rating;
    data['type'] = type;
    return data;
  }
}

class Seasons {
  int? season;
  Image? image;
  List<Episodes>? episodes;
  bool? isReleased;

  Seasons({this.season, this.image, this.episodes, this.isReleased});

  Seasons.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(Episodes.fromJson(v));
      });
    }
    isReleased = json['isReleased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['season'] = season;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (episodes != null) {
      data['episodes'] = episodes!.map((v) => v.toJson()).toList();
    }
    data['isReleased'] = isReleased;
    return data;
  }
}

class Image {
  String? mobile;
  String? hd;

  Image({this.mobile, this.hd});

  Image.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    hd = json['hd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mobile'] = mobile;
    data['hd'] = hd;
    return data;
  }
}

class Episodes {
  String? id;
  String? title;
  int? episode;
  int? season;
  String? releaseDate;
  String? description;
  String? url;
  Image? img;

  Episodes(
      {this.id,
      this.title,
      this.episode,
      this.season,
      this.releaseDate,
      this.description,
      this.url,
      this.img});

  Episodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    episode = json['episode'];
    season = json['season'];
    releaseDate = json['releaseDate'];
    description = json['description'];
    url = json['url'];
    img = json['img'] != null ? Image.fromJson(json['img']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['episode'] = episode;
    data['season'] = season;
    data['releaseDate'] = releaseDate;
    data['description'] = description;
    data['url'] = url;
    if (img != null) {
      data['img'] = img!.toJson();
    }
    return data;
  }
}
