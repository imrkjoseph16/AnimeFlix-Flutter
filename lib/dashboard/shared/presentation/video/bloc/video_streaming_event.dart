part of 'video_streaming_bloc.dart';

@immutable
sealed class VideoStreamingEvent {}

class GetVideoStreamEvent extends VideoStreamingEvent {
  String? streamId;
  GetVideoStreamEvent({required this.streamId});
}
