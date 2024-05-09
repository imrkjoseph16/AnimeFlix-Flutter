import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';

class VideoWatchedDetails {
  String name;
  String image;
  String id;
  int duration;
  int totalDuration;
  num watchedEpisode;
  ItemType itemType;
  String lastDateWatched;

  VideoWatchedDetails(
      {required this.name,
      required this.image,
      required this.id,
      required this.duration,
      required this.totalDuration,
      required this.watchedEpisode,
      required this.itemType,
      required this.lastDateWatched});

  factory VideoWatchedDetails.fromMap(Map<String, dynamic> map) => VideoWatchedDetails(
      name: map['name'],
      image: map['image'],
      id: map['id'],
      duration: map['duration'],
      totalDuration: map['totalDuration'],
      watchedEpisode: map['watchedEpisode'],
      itemType:
          ItemType.values.byName(map['itemType'].toString().toUpperCase()),
      lastDateWatched: map['lastDateWatched'],
    );

  Map<String, dynamic> toMap() => {
      'name': name,
      'image': image,
      'id': id,
      'duration': duration,
      'totalDuration': totalDuration,
      'watchedEpisode': watchedEpisode,
      'itemType': itemType.value,
      'lastDateWatched': lastDateWatched,
    };
}
