part of 'video_streaming_bloc.dart';

@immutable
sealed class VideoStreamingState {}

final class VideoStreamingInitial extends VideoStreamingState {}

final class LoadingState extends VideoStreamingState {}

final class NoDataState extends VideoStreamingState {}

final class GetStreamingDetails extends VideoStreamingState {
  StreamingLinkResponse? response;
  GetStreamingDetails({this.response});
}
