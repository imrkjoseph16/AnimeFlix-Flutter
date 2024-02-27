part of 'shared_bloc.dart';

sealed class SharedState {}

final class SharedInitial extends SharedState {}

final class LoadingState extends SharedState {}

final class NoDataState extends SharedState {}

class GetAnimeList extends SharedState {
  GetAnimeUiItems? items;
  GetAnimeList({this.items});
}

class GetExploreList extends SharedState {
  AnimeResponse? response;
  GetExploreList({this.response});
}

class GetAnimeDetails extends SharedState {
  AnimeDetailsResponse? details;
  GetAnimeDetails({this.details});
}

class GetAnimeUiItems {
  List<Results>? carouselList = [];
  AnimeResponse? topAnime;
  AnimeResponse? recentEpisodes;
  AnimeResponse? popularAnime;
  AnimeResponse? randomAnime;
  AnimeResponse? airingAnime;

  GetAnimeUiItems(
      {this.carouselList,
      this.topAnime,
      this.recentEpisodes,
      this.popularAnime,
      this.randomAnime,
      this.airingAnime});
}
