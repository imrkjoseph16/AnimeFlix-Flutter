import 'package:anime_nation/dashboard/shared/data/dto/anime_details_response.dart';
import 'package:anime_nation/dashboard/shared/data/dto/anime_response.dart';
import 'package:anime_nation/dashboard/shared/data/repository/anime_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  SharedRepository sharedRepository = SharedRepository();
  GetAnimeUiItems uiItems = GetAnimeUiItems();

  SharedBloc() : super(SharedInitial()) {
    on<GetAnimeEvent>((event, emit) async {
      emit(LoadingState());
      AnimeResponse? result =
          await sharedRepository.getAnimeList(event.animeType.value);

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
      emit(GetAnimeList(items: uiItems));
    });

    on<AnimeDetailsEvent>((event, emit) async {
      emit(LoadingState());
      AnimeDetailsResponse? result =
          await sharedRepository.getAnimeDetails(event.detailsId);
      if (result != null) {
        emit(GetAnimeDetails(details: result));
      } else {
        emit(NoDataState());
      }
    });

    on<ExploreAnimeEvent>((event, emit) async {
      emit(LoadingState());
      AnimeResponse? result =
          await sharedRepository.getAnimeList(event.queryName);
      if (result != null) {
        emit(GetExploreList(response: result));
      } else {
        emit(NoDataState());
      }
    });
  }
}

class ExploreBloc extends Bloc<SharedEvent, SharedState> {
  SharedRepository sharedRepository = SharedRepository();

  ExploreBloc() : super(SharedInitial()) {
    on<ExploreAnimeEvent>((event, emit) async {
      emit(LoadingState());
      AnimeResponse? result =
          await sharedRepository.getAnimeList(event.queryName);
      if (result != null) {
        emit(GetExploreList(response: result));
      } else {
        emit(NoDataState());
      }
    });
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
