part of 'shared_bloc.dart';

sealed class SharedState {}

final class SharedInitial extends SharedState {}

final class LoadingState extends SharedState {}

final class NoDataState extends SharedState {}

class GetHomeItemsList extends SharedState {
  GetHomeUiItems? items;
  GetHomeItemsList({this.items});
}

class GetItemDetails extends SharedState {
  DetailsFullData? details;
  GetItemDetails({this.details});
}

class GetHomeUiItems {
  List<Results>? carouselList = [];
  ListFullData? continueWatchList;
  ListFullData? topAnime;
  ListFullData? recentEpisodes;
  ListFullData? popularAnime;
  ListFullData? randomAnime;
  ListFullData? airingAnime;
  ListFullData? randomKorean;
  ListFullData? randomMovie;

  GetHomeUiItems(
      {this.carouselList,
      this.topAnime,
      this.recentEpisodes,
      this.popularAnime,
      this.randomAnime,
      this.airingAnime});
}
