import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart';
import 'package:anime_nation/dashboard/shared/data/dao/list_full_data.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/anime_repository.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/korean_repository.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/movies_repository.dart';
import 'package:anime_nation/shared/domain/firebase_shared_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  GetHomeUiItems uiItems = GetHomeUiItems();

  SharedBloc() : super(SharedInitial()) {
    on<GetContinueWatchingEvent>(_geContinueWatchingList);
    on<GetAnimeEvent>(_getAnimeList);
    on<GetKoreanEvent>(_getKoreanList);
    on<GetMovieEvent>(_getMovieList);
    on<VerifyDetailsEvent>(_verifyDetailsState);
  }

  void _geContinueWatchingList(
      GetContinueWatchingEvent event, Emitter<SharedState> emit) {
    Stream<ListFullData?> result =
        locator<FirebaseSharedUseCase>().geContinueWatchingList();
    result.listen((list) {
      try {
        uiItems.continueWatchList = list;
        emit(GetHomeItemsList(items: uiItems));
      } catch (e) {}
    });
  }

  Future<void> _getAnimeList(
      GetAnimeEvent event, Emitter<SharedState> emit) async {
    emit(LoadingState());
    ListFullData? result =
        await locator<AnimeRepository>().getAnimeList(event.animeType.value);

    switch (event.animeType) {
      case AnimeType.POPULAR:
        uiItems.popularAnime = result;
        break;
      case AnimeType.RECENT:
        uiItems.recentEpisodes = result;
        break;
      case AnimeType.RANDOM:
        uiItems.randomAnime = result;
        break;
      case AnimeType.AIRING:
        uiItems.airingAnime = result;
        break;
      default:
        uiItems.carouselList = result?.results?.take(5).toList();
        uiItems.topAnime = result;
    }
    emit(GetHomeItemsList(items: uiItems));
  }

  Future<void> _getKoreanList(
      GetKoreanEvent event, Emitter<SharedState> emit) async {
    ListFullData? result =
        await locator<KoreanRepository>().getKoreanList(event.queryName);

    uiItems.randomKorean = result;

    emit(GetHomeItemsList(items: uiItems));
  }

  Future<void> _getMovieList(
      GetMovieEvent event, Emitter<SharedState> emit) async {
    ListFullData? result =
        await locator<MoviesRepository>().getMoviesList(event.queryName);

    uiItems.randomMovie = result;

    emit(GetHomeItemsList(items: uiItems));
  }

  Future<void> _verifyDetailsState(
      VerifyDetailsEvent event, Emitter<SharedState> emit) async {
    DetailsFullData? result;

    emit(LoadingState());
    switch (event.type) {
      case ItemType.KOREAN:
        result =
            await locator<KoreanRepository>().getKoreanDetails(event.detailsId);
        break;
      case ItemType.MOVIES:
        result = await locator<MoviesRepository>()
            .getMovieDetails(event.detailsId, event.typeOfMovie ?? "");
        break;
      default:
        result =
            await locator<AnimeRepository>().getAnimeDetails(event.detailsId);
    }

    if (result != null) {
      emit(GetItemDetails(details: result));
    } else {
      emit(NoDataState());
    }
  }
}

enum AnimeType {
  TRENDING("trending"),
  RECENT("recent-episodes"),
  POPULAR("popular"),
  RANDOM("new"),
  AIRING("airing-schedule");

  const AnimeType(this.value);
  final String value;
}

enum ItemType {
  EXPLORE("explore"),
  ANIME("anime"),
  KOREAN("korean"),
  MOVIES("movies");

  const ItemType(this.value);
  final String value;
}
