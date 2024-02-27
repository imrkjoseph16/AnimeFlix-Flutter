import 'package:anime_nation/dashboard/shared/data/repository/anime_repository.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/streaming_link_response.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_streaming_event.dart';
part 'video_streaming_state.dart';

class VideoStreamingBloc
    extends Bloc<VideoStreamingEvent, VideoStreamingState> {
  SharedRepository sharedRepository = SharedRepository();

  VideoStreamingBloc() : super(VideoStreamingInitial()) {
    on<GetVideoStreamEvent>((event, emit) async {
      emit(LoadingState());

      StreamingLinkResponse? response =
          await sharedRepository.getStreamLink(event.streamId);

      if (response != null) {
        emit(GetStreamingDetails(response: response));
      } else {
        emit(NoDataState());
      }
    });
  }
}
