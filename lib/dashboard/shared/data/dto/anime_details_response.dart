class AnimeDetailsResponse {
  String? id;
  Title? title;
  int? malId;
  List<String>? synonyms;
  bool? isLicensed;
  bool? isAdult;
  String? countryOfOrigin;
  Trailer? trailer;
  String? image;
  String? imageHash;
  int? popularity;
  String? color;
  String? cover;
  String? coverHash;
  String? description;
  String? status;
  int? releaseDate;
  StartDate? startDate;
  EndDate? endDate;
  NextAiringEpisode? nextAiringEpisode;
  int? totalEpisodes;
  int? currentEpisode;
  int? rating;
  int? duration;
  List<String>? genres;
  String? season;
  List<String>? studios;
  String? subOrDub;
  String? type;
  List<Recommendations>? recommendations;
  List<Characters>? characters;
  List<Relations>? relations;
  List<Mappings>? mappings;
  List<Artwork>? artwork;
  List<Episodes>? episodes;

  AnimeDetailsResponse(
      {this.id,
      this.title,
      this.malId,
      this.synonyms,
      this.isLicensed,
      this.isAdult,
      this.countryOfOrigin,
      this.trailer,
      this.image,
      this.imageHash,
      this.popularity,
      this.color,
      this.cover,
      this.coverHash,
      this.description,
      this.status,
      this.releaseDate,
      this.startDate,
      this.endDate,
      this.nextAiringEpisode,
      this.totalEpisodes,
      this.currentEpisode,
      this.rating,
      this.duration,
      this.genres,
      this.season,
      this.studios,
      this.subOrDub,
      this.type,
      this.recommendations,
      this.characters,
      this.relations,
      this.mappings,
      this.artwork,
      this.episodes});

  AnimeDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    malId = json['malId'];
    synonyms = json['synonyms'] == null ? [] : json['synonyms'].cast<String>();
    isLicensed = json['isLicensed'];
    isAdult = json['isAdult'];
    countryOfOrigin = json['countryOfOrigin'];
    trailer =
        json['trailer'] != null ? Trailer.fromJson(json['trailer']) : null;
    image = json['image'];
    imageHash = json['imageHash'];
    popularity = json['popularity'];
    color = json['color'];
    cover = json['cover'];
    coverHash = json['coverHash'];
    description = json['description'];
    status = json['status'];
    releaseDate = json['releaseDate'];
    startDate = json['startDate'] != null
        ? StartDate.fromJson(json['startDate'])
        : null;
    endDate =
        json['endDate'] != null ? EndDate.fromJson(json['endDate']) : null;
    nextAiringEpisode = json['nextAiringEpisode'] != null
        ? NextAiringEpisode.fromJson(json['nextAiringEpisode'])
        : null;
    totalEpisodes = json['totalEpisodes'];
    currentEpisode = json['currentEpisode'];
    rating = json['rating'];
    duration = json['duration'];
    genres = json['genres'] == null ? [] : json['genres'].cast<String>();
    season = json['season'];
    studios = json['studios'] == null ? [] : json['studios'].cast<String>();
    subOrDub = json['subOrDub'];
    type = json['type'];
    if (json['recommendations'] != null) {
      recommendations = <Recommendations>[];
      json['recommendations'].forEach((v) {
        recommendations!.add(Recommendations.fromJson(v));
      });
    }
    if (json['characters'] != null) {
      characters = <Characters>[];
      json['characters'].forEach((v) {
        characters!.add(Characters.fromJson(v));
      });
    }
    if (json['relations'] != null) {
      relations = <Relations>[];
      json['relations'].forEach((v) {
        relations!.add(Relations.fromJson(v));
      });
    }
    if (json['mappings'] != null) {
      mappings = <Mappings>[];
      json['mappings'].forEach((v) {
        mappings!.add(Mappings.fromJson(v));
      });
    }
    if (json['artwork'] != null) {
      artwork = <Artwork>[];
      json['artwork'].forEach((v) {
        artwork!.add(Artwork.fromJson(v));
      });
    }
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(Episodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    data['malId'] = this.malId;
    data['synonyms'] = this.synonyms;
    data['isLicensed'] = this.isLicensed;
    data['isAdult'] = this.isAdult;
    data['countryOfOrigin'] = this.countryOfOrigin;
    if (this.trailer != null) {
      data['trailer'] = this.trailer!.toJson();
    }
    data['image'] = this.image;
    data['imageHash'] = this.imageHash;
    data['popularity'] = this.popularity;
    data['color'] = this.color;
    data['cover'] = this.cover;
    data['coverHash'] = this.coverHash;
    data['description'] = this.description;
    data['status'] = this.status;
    data['releaseDate'] = this.releaseDate;
    if (this.startDate != null) {
      data['startDate'] = this.startDate!.toJson();
    }
    if (this.endDate != null) {
      data['endDate'] = this.endDate!.toJson();
    }
    if (this.nextAiringEpisode != null) {
      data['nextAiringEpisode'] = this.nextAiringEpisode!.toJson();
    }
    data['totalEpisodes'] = this.totalEpisodes;
    data['currentEpisode'] = this.currentEpisode;
    data['rating'] = this.rating;
    data['duration'] = this.duration;
    data['genres'] = this.genres;
    data['season'] = this.season;
    data['studios'] = this.studios;
    data['subOrDub'] = this.subOrDub;
    data['type'] = this.type;
    if (this.recommendations != null) {
      data['recommendations'] =
          this.recommendations!.map((v) => v.toJson()).toList();
    }
    if (this.characters != null) {
      data['characters'] = this.characters!.map((v) => v.toJson()).toList();
    }
    if (this.relations != null) {
      data['relations'] = this.relations!.map((v) => v.toJson()).toList();
    }
    if (this.mappings != null) {
      data['mappings'] = this.mappings!.map((v) => v.toJson()).toList();
    }
    if (this.artwork != null) {
      data['artwork'] = this.artwork!.map((v) => v.toJson()).toList();
    }
    if (this.episodes != null) {
      data['episodes'] = this.episodes!.map((v) => v.toJson()).toList();
    }
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

class StartDate {
  int? year;
  int? month;
  int? day;

  StartDate({this.year, this.month, this.day});

  StartDate.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
    return data;
  }
}

class EndDate {
  int? year;
  int? month;
  int? day;

  EndDate({this.year, this.month, this.day});

  EndDate.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
    return data;
  }
}

class NextAiringEpisode {
  int? airingTime;
  int? timeUntilAiring;
  int? episode;

  NextAiringEpisode({this.airingTime, this.timeUntilAiring, this.episode});

  NextAiringEpisode.fromJson(Map<String, dynamic> json) {
    airingTime = json['airingTime'];
    timeUntilAiring = json['timeUntilAiring'];
    episode = json['episode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['airingTime'] = this.airingTime;
    data['timeUntilAiring'] = this.timeUntilAiring;
    data['episode'] = this.episode;
    return data;
  }
}

class Recommendations {
  int? id;
  int? malId;
  Title? title;
  String? status;
  int? episodes;
  String? image;
  String? imageHash;
  String? cover;
  String? coverHash;
  int? rating;
  String? type;

  Recommendations(
      {this.id,
      this.malId,
      this.title,
      this.status,
      this.episodes,
      this.image,
      this.imageHash,
      this.cover,
      this.coverHash,
      this.rating,
      this.type});

  Recommendations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    malId = json['malId'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    status = json['status'];
    episodes = json['episodes'];
    image = json['image'];
    imageHash = json['imageHash'];
    cover = json['cover'];
    coverHash = json['coverHash'];
    rating = json['rating'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['malId'] = this.malId;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    data['status'] = this.status;
    data['episodes'] = this.episodes;
    data['image'] = this.image;
    data['imageHash'] = this.imageHash;
    data['cover'] = this.cover;
    data['coverHash'] = this.coverHash;
    data['rating'] = this.rating;
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

class Characters {
  int? id;
  String? role;
  Name? name;
  String? image;
  String? imageHash;
  List<VoiceActors>? voiceActors;

  Characters(
      {this.id,
      this.role,
      this.name,
      this.image,
      this.imageHash,
      this.voiceActors});

  Characters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
    imageHash = json['imageHash'];
    if (json['voiceActors'] != null) {
      voiceActors = <VoiceActors>[];
      json['voiceActors'].forEach((v) {
        voiceActors!.add(new VoiceActors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['image'] = this.image;
    data['imageHash'] = this.imageHash;
    if (this.voiceActors != null) {
      data['voiceActors'] = this.voiceActors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Name {
  String? first;
  String? last;
  String? full;
  String? native;
  String? userPreferred;

  Name({this.first, this.last, this.full, this.native, this.userPreferred});

  Name.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    full = json['full'];
    native = json['native'];
    userPreferred = json['userPreferred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['full'] = this.full;
    data['native'] = this.native;
    data['userPreferred'] = this.userPreferred;
    return data;
  }
}

class VoiceActors {
  int? id;
  String? language;
  Name? name;
  String? image;
  String? imageHash;

  VoiceActors({this.id, this.language, this.name, this.image, this.imageHash});

  VoiceActors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
    imageHash = json['imageHash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language'] = this.language;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['image'] = this.image;
    data['imageHash'] = this.imageHash;
    return data;
  }
}

class Relations {
  int? id;
  String? relationType;
  int? malId;
  Title? title;
  String? status;
  int? episodes;
  String? image;
  String? imageHash;
  String? color;
  String? type;
  String? cover;
  String? coverHash;
  int? rating;

  Relations(
      {this.id,
      this.relationType,
      this.malId,
      this.title,
      this.status,
      this.episodes,
      this.image,
      this.imageHash,
      this.color,
      this.type,
      this.cover,
      this.coverHash,
      this.rating});

  Relations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relationType = json['relationType'];
    malId = json['malId'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    status = json['status'];
    episodes = json['episodes'];
    image = json['image'];
    imageHash = json['imageHash'];
    color = json['color'];
    type = json['type'];
    cover = json['cover'];
    coverHash = json['coverHash'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['relationType'] = this.relationType;
    data['malId'] = this.malId;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    data['status'] = this.status;
    data['episodes'] = this.episodes;
    data['image'] = this.image;
    data['imageHash'] = this.imageHash;
    data['color'] = this.color;
    data['type'] = this.type;
    data['cover'] = this.cover;
    data['coverHash'] = this.coverHash;
    data['rating'] = this.rating;
    return data;
  }
}

class Mappings {
  String? id;
  String? providerId;
  String? providerType;

  Mappings({this.id, this.providerId, this.providerType});

  Mappings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['providerId'];
    providerType = json['providerType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['providerId'] = this.providerId;
    data['providerType'] = this.providerType;
    return data;
  }
}

class Artwork {
  String? img;
  String? type;
  String? providerId;

  Artwork({this.img, this.type, this.providerId});

  Artwork.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    type = json['type'];
    providerId = json['providerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['type'] = this.type;
    data['providerId'] = this.providerId;
    return data;
  }
}

class Episodes {
  String? id;
  String? title;
  String? description;
  num? number;
  String? image;
  String? imageHash;
  String? airDate;

  Episodes(
      {this.id,
      this.title,
      this.description,
      this.number,
      this.image,
      this.imageHash,
      this.airDate});

  Episodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    number = json['number'];
    image = json['image'];
    imageHash = json['imageHash'];
    airDate = json['airDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['number'] = this.number;
    data['image'] = this.image;
    data['imageHash'] = this.imageHash;
    data['airDate'] = this.airDate;
    return data;
  }
}
