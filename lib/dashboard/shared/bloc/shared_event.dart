part of 'shared_bloc.dart';

sealed class SharedEvent {}

class GetAnimeEvent extends SharedEvent {
  AnimeType animeType;
  GetAnimeEvent({required this.animeType});
}

class ExploreAnimeEvent extends SharedEvent {
  String queryName;
  ExploreAnimeEvent({required this.queryName});
}

class AnimeDetailsEvent extends SharedEvent {
  String detailsId;
  AnimeDetailsEvent({required this.detailsId});
}
