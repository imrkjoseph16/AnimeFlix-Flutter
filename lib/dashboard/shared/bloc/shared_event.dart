part of 'shared_bloc.dart';

sealed class SharedEvent {}

class GetContinueWatchingEvent extends SharedEvent {
  GetContinueWatchingEvent();
}

class GetAnimeEvent extends SharedEvent {
  AnimeType animeType;
  GetAnimeEvent({required this.animeType});
}

class GetKoreanEvent extends SharedEvent {
  String queryName;
  GetKoreanEvent({required this.queryName});
}

class GetMovieEvent extends SharedEvent {
  String queryName;
  GetMovieEvent({required this.queryName});
}

class VerifyDetailsEvent extends SharedEvent {
  ItemType type;
  String detailsId;
  String? typeOfMovie;
  VerifyDetailsEvent(
      {required this.type, required this.detailsId, this.typeOfMovie});
}
