import 'package:anime_nation/app/util/view_util.dart';
import 'package:anime_nation/app/widget/error_found_widget.dart';
import 'package:anime_nation/dashboard/shared/data/dto/anime_details_response.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/bloc/video_streaming_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/video_player_widget.dart';

class VideoStreamingPage extends StatefulWidget {
  final VideoStreamingArguments args;
  const VideoStreamingPage({super.key, required this.args});

  @override
  State<VideoStreamingPage> createState() => _VideoStreamingPageState();
}

class _VideoStreamingPageState extends State<VideoStreamingPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VideoStreamingBloc>(context)
        .add(GetVideoStreamEvent(streamId: extraStreamId()));
  }

  String? extraStreamId() {
    List<Episodes>? episode = widget.args.details?.episodes;
    // We neeed to decrement the selectedEpisode by 1,
    // since the index of arrayList and episodes is not equal,
    // Example: ArrayList starts with zero index while the,
    // episode number starts with "1"
    return episode?.isEmpty == true
        ? ""
        : episode![widget.args.selectedEpisode.toInt() - 1].id;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: BlocBuilder<VideoStreamingBloc, VideoStreamingState>(
        builder: (context, state) {
          if (state is GetStreamingDetails) {
            return VideoPlayerWidget(
                args: widget.args,
                streamLink:
                    ViewUtil.getBestQualityUrl(state.response?.sources) ?? "");
          } else if (state is NoDataState) {
            return const ErrorFoundWidget();
          } else {
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
        },
      ),
    );
  }
}

class VideoStreamingArguments {
  final AnimeDetailsResponse? details;
  num selectedEpisode = 0;
  VideoStreamingArguments(
      {required this.details, required this.selectedEpisode});
}
