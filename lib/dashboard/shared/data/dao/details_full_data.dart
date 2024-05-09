class DetailsFullData {
  String? id;
  Title? title;
  List<String>? synonyms;
  List<String>? otherNames;
  bool? isLicensed;
  bool? isAdult;
  String? countryOfOrigin;
  Trailer? trailer;
  String? image;
  int? popularity;
  String? color;
  String? cover;
  String? description;
  String? status;
  String? releaseDate;
  StartDate? startDate;
  List<Logos>? logos;
  EndDate? endDate;
  NextAiringEpisode? nextAiringEpisode;
  int? totalEpisodes;
  int? currentEpisode;
  num? rating;
  int? duration;
  List<String>? genres;
  String? season;
  List<String>? studios;
  String? subOrDub;
  String? type;
  List<Recommendations>? recommendations;
  List<Translations>? translations;
  List<Characters>? characters;
  List<String>? directors;
  List<String>? writers;
  List<Relations>? relations;
  List<Artwork>? artwork;
  List<Episodes>? episodes;
  int? totalSeasons;
  List<Seasons>? seasons;

  DetailsFullData(
      {this.id,
      this.title,
      this.synonyms,
      this.isLicensed,
      this.isAdult,
      this.countryOfOrigin,
      this.trailer,
      this.image,
      this.popularity,
      this.color,
      this.logos,
      this.cover,
      this.description,
      this.status,
      this.releaseDate,
      this.startDate,
      this.totalSeasons,
      this.otherNames,
      this.seasons,
      this.endDate,
      this.nextAiringEpisode,
      this.totalEpisodes,
      this.currentEpisode,
      this.rating,
      this.duration,
      this.genres,
      this.translations,
      this.season,
      this.studios,
      this.subOrDub,
      this.type,
      this.recommendations,
      this.characters,
      this.directors,
      this.writers,
      this.relations,
      this.artwork,
      this.episodes});
}

class Translations {
  String? description;
  String? language;
  String? title;

  Translations({this.description, this.language, this.title});
}

class Logos {
  String? url;
  double? aspectRatio;
  int? width;

  Logos({this.url, this.aspectRatio, this.width});
}

class Trailer {
  String? id;
  String? site;
  String? thumbnail;
  String? url;

  Trailer({this.id, this.site, this.thumbnail, this.url});
}

class StartDate {
  int? year;
  int? month;
  int? day;

  StartDate({this.year, this.month, this.day});
}

class EndDate {
  int? year;
  int? month;
  int? day;

  EndDate({this.year, this.month, this.day});
}

class NextAiringEpisode {
  int? airingTime;
  int? timeUntilAiring;
  int? episode;

  NextAiringEpisode({this.airingTime, this.timeUntilAiring, this.episode});
}

class Recommendations {
  int? id;
  Title? title;
  String? status;
  int? episodes;
  String? image;
  String? cover;
  num? rating;
  String? type;
  String? releaseDate;

  Recommendations(
      {this.id,
      this.title,
      this.status,
      this.episodes,
      this.image,
      this.cover,
      this.rating,
      this.type,
      this.releaseDate});
}

class Title {
  String? english;
  String? native;
  String? userPreferred;

  Title({this.english, this.native, this.userPreferred});
}

class Characters {
  int? id;
  String? role;
  Name? name;
  String? image;
  List<VoiceActors>? voiceActors;

  Characters({this.id, this.role, this.name, this.image, this.voiceActors});
}

class Name {
  String? first;
  String? last;
  String? full;
  String? native;
  String? userPreferred;

  Name({this.first, this.last, this.full, this.native, this.userPreferred});
}

class VoiceActors {
  int? id;
  String? language;
  Name? name;
  String? image;

  VoiceActors({this.id, this.language, this.name, this.image});
}

class Relations {
  int? id;
  String? relationType;
  Title? title;
  String? status;
  int? episodes;
  String? image;
  String? color;
  String? type;
  String? cover;
  String? releaseDate;
  num? rating;

  Relations(
      {this.id,
      this.relationType,
      this.title,
      this.status,
      this.episodes,
      this.image,
      this.color,
      this.type,
      this.cover,
      this.releaseDate,
      this.rating});
}

class Mappings {
  String? id;
  String? providerId;
  String? providerType;

  Mappings({this.id, this.providerId, this.providerType});
}

class Artwork {
  String? img;
  String? type;
  String? providerId;

  Artwork({this.img, this.type, this.providerId});
}

class Episodes {
  String? id;
  String? title;
  String? description;
  num? number;
  num? episode;
  num? season;
  String? image;
  String? airDate;
  String? type;
  String? url;
  Image? img;

  Episodes(
      {this.id,
      this.title,
      this.description,
      this.episode,
      this.season,
      this.type,
      this.number,
      this.image,
      this.airDate,
      this.img,
      this.url});
}

class Seasons {
  int? season;
  Image? image;
  List<Episodes>? episodes;
  bool? isReleased;

  Seasons({this.season, this.image, this.episodes, this.isReleased});
}

class Image {
  String? mobile;
  String? hd;

  Image({this.mobile, this.hd});
}
