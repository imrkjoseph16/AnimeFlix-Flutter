// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names, constant_identifier_names

import 'dart:async';

import 'package:anime_nation/app/widget/card_play_details_widget.dart';
import 'package:anime_nation/dashboard/shared/data/dto/anime_details_response.dart'
    as details;
import 'package:anime_nation/app/widget/bottom_shet_widget.dart';
import 'package:anime_nation/dashboard/shared/data/dto/anime_details_response.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/video_streaming_page.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoController extends StatefulWidget {
  final BuildContext context;
  final VideoStreamingArguments args;
  final String streamLink;
  final VideoPlayerController controller;
  VideoController(
      {required this.context,
      required this.args,
      required this.streamLink,
      required this.controller});

  @override
  State<VideoController> createState() => _VideoControllertState();
}

class _VideoControllertState extends State<VideoController> {
  static const List<double> playBackSpeedList = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  bool canShowControls = false;
  bool canShowRecommendation = false;
  Timer? timerDelayed;

  @override
  void initState() {
    super.initState();
    setupObserver();
  }

  @override
  void dispose() {
    timerDelayed?.cancel();
    super.dispose();
  }

  void setupObserver() {
    widget.controller.addListener(() {
      if ((widget.controller.value.isCompleted)) {
        goToPlayBackState(PlayBackState.NEXT);
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ScreenTapDetector(),
        canShowControls
            ? Stack(
                children: [
                  TopControls(),
                  CenterControls(),
                  BottomControls(),
                  RecommendedList(context)
                ],
              )
            : const SizedBox.shrink()
      ],
    );
  }

  Widget ScreenTapDetector() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (canShowControls)
            canShowControls = false;
          else
            canShowControls = true;
          setControlDelayed();
        });
      },
    );
  }

  Widget TopControls() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setTopState) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: InkWell(
              onTap: () => {
                Navigator.of(context).pop(),
                AutoOrientation.portraitUpMode()
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                    size: 24,
                    semanticLabel: "Back",
                    shadows: <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 15.0)
                    ],
                    Icons.arrow_back,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Text(setupTitle(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "SfProTextBold",
                  shadows: [
                    Shadow(
                      blurRadius: 8.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PopupMenuButton<double>(
                    initialValue: widget.controller.value.playbackSpeed,
                    tooltip: 'Playback Speed',
                    onSelected: (double speed) {
                      setTopState(() {
                        widget.controller.setPlaybackSpeed(speed);
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuItem<double>>[
                        for (final double speed in playBackSpeedList)
                          PopupMenuItem<double>(
                            value: speed,
                            child: Text('${speed}x',
                                style: const TextStyle(
                                    fontFamily: "SfProTextMedium")),
                          )
                      ];
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '${widget.controller.value.playbackSpeed}x speed',
                          style: const TextStyle(
                              shadows: <Shadow>[
                                Shadow(color: Colors.black, blurRadius: 15.0)
                              ],
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "SfProTextMedium")),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      setState(() => {
                            if (canShowRecommendation)
                              canShowRecommendation = false
                            else
                              canShowRecommendation = true
                          }),
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Episodes",
                        style: TextStyle(
                            shadows: <Shadow>[
                              Shadow(color: Colors.black, blurRadius: 15.0)
                            ],
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "SfProTextMedium"),
                      ),
                    ),
                  ),
                ]),
          )
        ],
      );
    });
  }

  Widget CenterControls() {
    return Center(
      child: Wrap(
        children: [
          InkWell(
            onTap: () => goToPlayBackState(PlayBackState.PREVIOUS),
            child: SetupIcon(Icons.skip_previous),
          ),
          InkWell(
            onTap: () =>
                controllSeekTo(widget.controller.value.position.inSeconds - 10),
            child: SetupIcon(Icons.replay_10),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: () => {
              widget.controller.value.isPlaying
                  ? widget.controller.pause()
                  : widget.controller.play()
            },
            child: ValueListenableBuilder(
                valueListenable: widget.controller,
                builder: (context, VideoPlayerValue value, child) {
                  return SetupIcon(value.isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill);
                }),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: () =>
                controllSeekTo(widget.controller.value.position.inSeconds + 10),
            child: SetupIcon(Icons.forward_10),
          ),
          InkWell(
            onTap: () => goToPlayBackState(PlayBackState.NEXT),
            child: SetupIcon(Icons.skip_next),
          ),
        ],
      ),
    );
  }

  Widget BottomControls() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ValueListenableBuilder(
                valueListenable: widget.controller,
                builder: (context, VideoPlayerValue value, child) {
                  return Text(
                      convertDuration(
                          widget.controller.value.position.inMilliseconds),
                      style: const TextStyle(
                          color: Colors.white, fontFamily: "SfProTextMedium"));
                },
              ),
              Flexible(
                child: VideoProgressIndicator(
                  widget.controller,
                  allowScrubbing: true,
                  colors:
                      VideoProgressColors(bufferedColor: Colors.red.shade100),
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                ),
              ),
              Text(
                convertDuration(
                    widget.controller.value.duration.inMilliseconds),
                style: const TextStyle(
                    color: Colors.white, fontFamily: "SfProTextMedium"),
              ),
            ],
          ),
        ));
  }

  Widget RecommendedList(BuildContext context) {
    return canShowRecommendation
        ? BottomSheetWidget(
            canShowBottomList: canShowRecommendation,
            onPanelClosed: () =>
                {canShowRecommendation = false, setControlDelayed()},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${widget.args.details?.title?.english ?? widget.args.details?.title?.native} (Episodes)",
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "SfProTextMedium",
                          fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.args.details?.episodes?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          Episodes? result =
                              widget.args.details?.episodes?[index];
                          return CardPlayDetailsWidget(
                            cardEnabled:
                                widget.args.selectedEpisode == index + 1
                                    ? false
                                    : true,
                            isHorizontal: true,
                            itemId: result?.id ?? "",
                            firstLine: widget.args.details?.title?.english ??
                                widget.args.details?.title?.native,
                            secondLine: "Episode: ${result?.number}",
                            thirdLine: "Status: ${widget.args.details?.status}",
                            image: result?.image ??
                                widget.args.details?.cover ??
                                widget.args.details?.image,
                            onItemClicked: (episodeId) {
                              goToStreamScreen(episode: result?.number ?? 0);
                            },
                          );
                        }),
                  ),
                ],
              ),
            ))
        : const SizedBox.shrink();
  }

  Widget SetupIcon(IconData icon) => Icon(
        icon,
        color: Colors.white,
        size: 40.0,
        shadows: const <Shadow>[Shadow(color: Colors.black, blurRadius: 8.0)],
      );

  String setupTitle() {
    details.Title? title = widget.args.details?.title;
    return "${title?.english ?? title?.native ?? ""}"
        " (Episode ${widget.args.selectedEpisode})";
  }

  convertDuration(int millisSeconds) {
    var duration = Duration(milliseconds: millisSeconds.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  void setControlDelayed() {
    if (timerDelayed?.isActive == true) timerDelayed?.cancel();
    timerDelayed = Timer(const Duration(seconds: 5), () {
      if (!canShowRecommendation && canShowControls) {
        try {
          setState(() {
            canShowControls = false;
          });
        } catch (e) {}
      }
    });
  }

  void goToPlayBackState(PlayBackState state) {
    switch (state) {
      case PlayBackState.NEXT:
        if (widget.args.details?.episodes?.length !=
            widget.args.selectedEpisode) {
          goToStreamScreen(episode: widget.args.selectedEpisode + 1);
        }
        break;
      default:
        if (widget.args.selectedEpisode != 1) {
          goToStreamScreen(episode: widget.args.selectedEpisode - 1);
        }
    }
  }

  void controllSeekTo(int duration) =>
      widget.controller.seekTo(Duration(seconds: duration));

  void goToStreamScreen({required num episode}) =>
      Navigator.of(context).popAndPushNamed('/watch',
          arguments: VideoStreamingArguments(
              details: widget.args.details, selectedEpisode: episode));
}

enum PlayBackState {
  PREVIOUS,
  NEXT;
}
