import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';

class ListFullData {
  int? currentPage;
  bool? hasNextPage;
  List<Results>? results;
  int? totalResults;
  int? totalPages;

  ListFullData(
      {this.currentPage,
      this.hasNextPage,
      this.results,
      this.totalResults,
      this.totalPages});
}

class Results {
  late String id;
  Title? title;
  String? image;
  String? episodeTitle;
  Trailer? trailer;
  String? description;
  String? status;
  String? cover;
  String? url;
  int? rating;
  String? releaseDate;
  String? color;
  List<String>? genres;
  int? totalEpisodes;
  int? duration;
  int? totalDuration;
  String? type;
  // this watchedEpisode and itemType is came from,
  // unfinish watching from user.
  num? watchedEpisode;
  ItemType? itemType;

  Results(
      {required this.id,
      this.title,
      this.image,
      this.episodeTitle,
      this.trailer,
      this.description,
      this.status,
      this.cover,
      this.url,
      this.rating,
      this.releaseDate,
      this.color,
      this.genres,
      this.totalEpisodes,
      this.duration,
      this.totalDuration,
      this.type,
      this.watchedEpisode,
      this.itemType});
}

class Title {
  String? english;
  String? native;
  String? userPreferred;

  Title({this.english, this.native, this.userPreferred});
}

class Trailer {
  String? id;
  String? site;
  String? thumbnail;

  Trailer({this.id, this.site, this.thumbnail});
}
