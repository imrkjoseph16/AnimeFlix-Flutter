// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names, constant_identifier_names, deprecated_member_use

import 'dart:async';
import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/app/util/view_util.dart';
import 'package:anime_nation/app/widget/card_play_details_widget.dart';
import 'package:anime_nation/app/widget/bottom_shet_widget.dart';
import 'package:anime_nation/app/widget/custom_icons.dart';
import 'package:anime_nation/dashboard/shared/bloc/shared_bloc.dart';
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart';
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart'
    as details;
import 'package:anime_nation/dashboard/shared/presentation/video/bloc/video_streaming_bloc.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/video_streaming_page.dart';
import 'package:anime_nation/shared/data/video_watched_details.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:video_player/video_player.dart';

class VideoController extends StatefulWidget {
  final BuildContext context;
  final VideoStreamingArguments args;
  final String streamLink;
  final DetailsFullData? details;
  final VideoPlayerController controller;
  const VideoController(
      {required this.context,
      required this.args,
      required this.streamLink,
      required this.details,
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
  double _brightness = 1.0;
  double _soundVolume = 1.0;

  @override
  void initState() {
    super.initState();
    setupObserver();
  }

  @override
  void dispose() {
    disposeComponents();
    super.dispose();
  }

  void setupObserver() {
    PerfectVolumeControl.hideUI = true;
    widget.controller.addListener(() {
      if ((widget.controller.value.isCompleted)) {
        goToPlayBackState(ControllerState.NEXT);
        return;
      }
    });
  }

  void disposeComponents() => timerDelayed?.cancel();

  void savedWatchedDetails() {
    var details = widget.details;

    context.read<VideoStreamingBloc>().add(OnSaveWatchedEvent(
        details: VideoWatchedDetails(
            name: details?.title?.english ?? details?.title?.native ?? "",
            image: details?.image ?? details?.cover ?? "",
            id: details?.id ?? "",
            duration: widget.controller.value.position.inSeconds,
            totalDuration: widget.controller.value.duration.inSeconds,
            watchedEpisode: widget.args.selectedEpisode,
            itemType: widget.args.itemType,
            lastDateWatched: DateTime.now().toString())));
  }

  void goBackToPreviousScreen() {
    Navigator.of(context).pop();
    AutoOrientation.portraitUpMode();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        savedWatchedDetails();
        return true;
      },
      child: BlocListener<VideoStreamingBloc, VideoStreamingState>(
        listener: (context, state) {
          if (state is OnSavedWatchDisposeState) {
            goBackToPreviousScreen();
          }
        },
        child: Stack(
          children: <Widget>[
            ScreenTapDetector(),
            canShowControls
                ? Stack(
                    children: [
                      TopControls(),
                      SideControls(),
                      CenterControls(),
                      BottomControls(),
                      RecommendedList(context)
                    ],
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget ScreenTapDetector() {
    return GestureDetector(
      onTap: () {
        sideControlValueListener();
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: InkWell(
              onTap: () => savedWatchedDetails(),
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
          const SizedBox(width: 16),
          Expanded(
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
              horizontal: 16,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, bottom: 8, right: 8),
                    child: PopupMenuButton<double>(
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
                      child: Text(
                          'Speed (${widget.controller.value.playbackSpeed}x)',
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
                      setState(() {
                        if (canShowRecommendation)
                          canShowRecommendation = false;
                        else
                          canShowRecommendation = true;
                      }),
                    },
                    child: const Text(
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
                ]),
          )
        ],
      );
    });
  }

  Widget SideControls() {
    return Align(
      alignment: Alignment.centerLeft,
      child: StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(CustomIcons.sun, color: Colors.white),
                  RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                          value: _brightness,
                          activeColor: Colors.red,
                          onChanged: (double value) => setSideControlValue(
                              ControllerState.BRIGHTNESS, setState, value))),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                      _soundVolume == 0.0
                          ? Icons.volume_off_rounded
                          : Icons.volume_up_rounded,
                      color: Colors.white),
                  RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                          value: _soundVolume,
                          activeColor: Colors.red,
                          onChanged: (double value) => setSideControlValue(
                              ControllerState.VOLUME, setState, value))),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget CenterControls() {
    return Center(
      child: Wrap(
        children: [
          InkWell(
            onTap: () => goToPlayBackState(ControllerState.PREVIOUS),
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
            onTap: () => goToPlayBackState(ControllerState.NEXT),
            child: SetupIcon(Icons.skip_next),
          ),
        ],
      ),
    );
  }

  Widget BottomControls() {
    var util = locator.get<ViewUtil>();
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
                      util.convertDuration(
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
                util.convertDuration(
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
            onPanelClosed: () => {
                  setState(() {
                    canShowRecommendation = false;
                    setControlDelayed();
                  })
                },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${widget.details?.title?.english ?? widget.details?.title?.native} (Episodes)",
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
                        itemCount: getEpisodeList()?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          Episodes? result = getEpisodeList()?[index];
                          return CardPlayDetailsWidget(
                            cardEnabled:
                                widget.args.selectedEpisode == index + 1
                                    ? false
                                    : true,
                            isHorizontal: true,
                            itemId: result?.id ?? "",
                            firstLine: widget.details?.title?.english ??
                                widget.details?.title?.native,
                            secondLine: result?.description ??
                                "Episode: ${result?.episode ?? result?.number}",
                            thirdLine: result?.airDate ??
                                "Status: ${widget.details?.status}",
                            image: result?.image ??
                                widget.details?.cover ??
                                widget.details?.image,
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

  List<Episodes>? getEpisodeList() {
    if (widget.args.itemType == ItemType.MOVIES) {
      return widget.details?.seasons?[0].episodes;
    } else {
      return widget.details?.episodes;
    }
  }

  Widget SetupIcon(IconData icon) => Icon(
        icon,
        color: Colors.white,
        size: 40.0,
        shadows: const <Shadow>[Shadow(color: Colors.black, blurRadius: 8.0)],
      );

  String setupTitle() {
    details.Title? title = widget.details?.title;
    return "${title?.english ?? title?.native ?? ""}"
        " (Episode ${widget.args.selectedEpisode})";
  }

  void setSideControlValue(
      ControllerState state, StateSetter setSideControl, double value) {
    setSideControl(() {
      if (state == ControllerState.BRIGHTNESS) {
        _brightness = value;
        ScreenBrightness().setScreenBrightness(_brightness);
      } else {
        _soundVolume = value;
        PerfectVolumeControl.setVolume(_soundVolume);
      }
    });
    setControlDelayed();
  }

  void sideControlValueListener() async {
    try {
      ScreenBrightness().current.then((value) => _brightness = value);
      PerfectVolumeControl.volume.then((value) => _soundVolume = value);
    } catch (e) {}
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

  void goToPlayBackState(ControllerState state) {
    switch (state) {
      case ControllerState.NEXT:
        if (widget.details?.episodes?.length != widget.args.selectedEpisode) {
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
              itemType: widget.args.itemType,
              detailsId: widget.args.detailsId,
              selectedEpisode: episode));
}

enum ControllerState {
  PREVIOUS,
  NEXT,
  BRIGHTNESS,
  VOLUME;
}
