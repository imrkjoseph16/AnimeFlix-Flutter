// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/app/util/view_util.dart';
import 'package:anime_nation/app/widget/error_found_widget.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/bloc/video_streaming_bloc.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/video_player_widget.dart';

class VideoStreamingPage extends StatefulWidget {
  final VideoStreamingArguments args;
  const VideoStreamingPage({super.key, required this.args});

  @override
  State<VideoStreamingPage> createState() => _VideoStreamingPageState();
}

class _VideoStreamingPageState extends State<VideoStreamingPage> {
  final _sharedBloc = SharedBloc();
  final _streamBloc = VideoStreamingBloc();

  @override
  void initState() {
    setupDecoration();
    super.initState();
  }

  @override
  void dispose() {
    _sharedBloc.close();
    _streamBloc.close();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _sharedBloc,
        ),
        BlocProvider(
          create: (context) => _streamBloc,
        ),
      ],
      child: Material(
          color: Colors.black, child: VideoStreamingBody(args: widget.args)),
    );
  }
}

void setupDecoration() {
  AutoOrientation.landscapeAutoMode(forceSensor: true);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class VideoStreamingBody extends StatefulWidget {
  final VideoStreamingArguments args;
  const VideoStreamingBody({super.key, required this.args});

  @override
  State<VideoStreamingBody> createState() => _VideoStreamingBodyState();
}

class _VideoStreamingBodyState extends State<VideoStreamingBody> {
  var util = locator.get<ViewUtil>();
  DetailsFullData? details;

  @override
  void initState() {
    super.initState();
    verifyDetailsEvent();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          goBackToPreviousScreen();
          return true;
        },
        child: BlocListener<SharedBloc, SharedState>(
          listener: (context, state) {
            if (state is GetItemDetails) {
              details = state.details;

              context.read<VideoStreamingBloc>().add(GetVideoStreamEvent(
                  itemType: widget.args.itemType,
                  streamId: extractStreamId(details?.episodes),
                  selectedEpisode: widget.args.selectedEpisode));
            }
          },
          child: BlocBuilder<VideoStreamingBloc, VideoStreamingState>(
            builder: (context, state) {
              if (state is GetStreamingDetails) {
                return VideoPlayerWidget(
                    args: widget.args,
                    streamLink: util.getBestQualityUrl(state.response?.sources),
                    details: details);
              } else if (state is EmptyDataState) {
                return ErrorFoundWidget();
              } else {
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    ));
              }
            },
          ),
        ),
      );

  void verifyDetailsEvent() {
    BlocProvider.of<SharedBloc>(context).add(VerifyDetailsEvent(
        type: widget.args.itemType,
        detailsId: widget.args.detailsId,
        typeOfMovie: widget.args.typeOfMovie));
  }

  String extractStreamId(List<Episodes>? episodes) {
    // We neeed to decrement the selectedEpisode by 1,
    // since the index of arrayList and episodes is not equal,
    // Example: ArrayList starts with zero index while the,
    // episode number starts with "1"
    if (widget.args.itemType == ItemType.MOVIES) {
      return widget.args.detailsId;
    } else {
      return episodes != null && episodes.isNotEmpty == true
          ? episodes[widget.args.selectedEpisode.toInt() - 1].id ?? ""
          : "";
    }
  }

  void goBackToPreviousScreen() => AutoOrientation.portraitUpMode();
}

class VideoStreamingArguments {
  final ItemType itemType;
  final String detailsId;
  final String? typeOfMovie;
  num selectedEpisode = 1;
  // for continue watching list,
  // incase stream is unfinish watching.
  int? lastDuration;
  VideoStreamingArguments(
      {required this.itemType,
      required this.detailsId,
      required this.selectedEpisode,
      this.typeOfMovie,
      this.lastDuration});
}
