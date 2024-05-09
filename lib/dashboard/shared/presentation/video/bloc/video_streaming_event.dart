part of 'video_streaming_bloc.dart';

@immutable
sealed class VideoStreamingEvent {}

class GetVideoStreamEvent extends VideoStreamingEvent {
  ItemType itemType;
  String streamId;
  num? selectedEpisode;
  GetVideoStreamEvent(
      {required this.itemType,
      required this.streamId,
      this.selectedEpisode});
}

class OnSaveWatchedEvent extends VideoStreamingEvent {
  VideoWatchedDetails details;
  OnSaveWatchedEvent({required this.details});
}

class CheckWatchedDurationEvent extends VideoStreamingEvent {
  String detailsId;
  CheckWatchedDurationEvent({required this.detailsId});
}
