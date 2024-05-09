// ignore_for_file: depend_on_referenced_packages

import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/data/dao/list_full_data.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/anime_repository.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/korean_repository.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/movies_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreUiItems uiItems = ExploreUiItems();

  ExploreBloc() : super(ExploreInitial()) {
    on<GetExploreEvent>(_getExploreContentList);
  }

  Future<void> _getExploreContentList(
      GetExploreEvent event, Emitter<ExploreState> emit) async {
    emit(LoadingState());
    uiItems.itemReset = event.itemReset;
    switch (event.type) {
      case ItemType.ANIME:
        uiItems.animeResult =
            await locator<AnimeRepository>().getAnimeList(event.queryName);
        break;
      case ItemType.KOREAN:
        uiItems.koreanResult =
            await locator<KoreanRepository>().getKoreanList(event.queryName);
        break;
      case ItemType.MOVIES:
        uiItems.movieResult =
            await locator<MoviesRepository>().getMoviesList(event.queryName);
        break;
      default:
        clearSearchResults();
        uiItems.exploreResult =
            await locator<AnimeRepository>().getAnimeList(event.queryName);
        break;
    }

    emit(GetExploreList(uiItems: uiItems));
  }

  void clearSearchResults() {
    uiItems.animeResult = null;
    uiItems.koreanResult = null;
    uiItems.movieResult = null;
  }
}

class ExploreUiItems {
  bool itemReset = true;
  ListFullData? exploreResult;
  ListFullData? animeResult;
  ListFullData? koreanResult;
  ListFullData? movieResult;
  ExploreUiItems(
      {this.exploreResult,
      this.animeResult,
      this.koreanResult,
      this.movieResult});
}
