part of 'video_streaming_bloc.dart';

@immutable
sealed class VideoStreamingState {}

final class VideoStreamingInitial extends VideoStreamingState {}

final class LoadingState extends VideoStreamingState {}

final class EmptyDataState extends VideoStreamingState {}

final class OnSavedWatchDisposeState extends VideoStreamingState {}

final class OnVerifyWatchedDurationState extends VideoStreamingState {
  VideoWatchedDetails? watchedDetails;
  OnVerifyWatchedDurationState({this.watchedDetails});
}

final class GetStreamingDetails extends VideoStreamingState {
  StreamFullData? response;
  GetStreamingDetails({this.response});
}
