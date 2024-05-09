// ignore_for_file: depend_on_referenced_packages

import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/anime_repository.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/korean_repository.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/movies_repository.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/dao/stream_full_data.dart';
import 'package:anime_nation/shared/data/video_watched_details.dart';
import 'package:anime_nation/shared/domain/firebase_shared_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_streaming_event.dart';
part 'video_streaming_state.dart';

class VideoStreamingBloc
    extends Bloc<VideoStreamingEvent, VideoStreamingState> {
  VideoStreamingBloc() : super(VideoStreamingInitial()) {
    on<GetVideoStreamEvent>(_getStreamLink);
    on<OnSaveWatchedEvent>(_saveWatchDetails);
    on<CheckWatchedDurationEvent>(_checkWatchedDuration);
  }

  Future<void> _getStreamLink(
      GetVideoStreamEvent event, Emitter<VideoStreamingState> emit) async {
    emit(LoadingState());

    StreamFullData? response;

    switch (event.itemType) {
      case ItemType.KOREAN:
        response =
            await locator<KoreanRepository>().getStreamLink(event.streamId);
        break;
      case ItemType.MOVIES:
        response = await locator<MoviesRepository>()
            .getStreamLink(event.streamId, 1, event.selectedEpisode?.toInt());
        break;
      default:
        response =
            await locator<AnimeRepository>().getStreamLink(event.streamId);
    }

    if (response != null) {
      emit(GetStreamingDetails(response: response));
    } else {
      emit(EmptyDataState());
    }
  }

  Future<void> _saveWatchDetails(
      OnSaveWatchedEvent event, Emitter<VideoStreamingState> emit) async {
    await locator<FirebaseSharedUseCase>().saveWatchedDuration(event.details);
    emit(OnSavedWatchDisposeState());
  }

  Future<void> _checkWatchedDuration(
      CheckWatchedDurationEvent event, Emitter<VideoStreamingState> emit) async {
    VideoWatchedDetails? watchedDetails = await locator<FirebaseSharedUseCase>()
        .checkWatchedDuration(event.detailsId);
    emit(OnVerifyWatchedDurationState(watchedDetails: watchedDetails));
  }
}
