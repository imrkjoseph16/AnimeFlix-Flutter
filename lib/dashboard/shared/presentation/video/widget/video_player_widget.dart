// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/app/util/view_util.dart';
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/video_streaming_page.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/widget/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoStreamingArguments args;
  final String streamLink;
  final DetailsFullData? details;

  const VideoPlayerWidget(
      {required this.args,
      required this.streamLink,
      required this.details,
      super.key});
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;
  var util = locator.get<ViewUtil>();

  @override
  void dispose() {
    disposeComponents();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initailSetup();
  }

  void initailSetup() async {
    controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.streamLink),
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
    );
    await controller.initialize();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    if (widget.args.lastDuration != null) {
      controllSeekTo(widget.args.lastDuration!);
    }
    controller.play();
  }

  void disposeComponents() {
    controller.pause();
    controller.dispose();
    ScreenBrightness().resetScreenBrightness();
  }

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AspectRatio(aspectRatio: 16 / 9, child: VideoPlayer(controller)),
          CenterLoading(),
          ForwardBackwardControls(context),
          VideoController(
              context: context,
              args: widget.args,
              streamLink: widget.streamLink,
              details: widget.details,
              controller: controller),
        ],
      );

  Widget CenterLoading() {
    return ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, VideoPlayerValue value, child) {
          return value.isBuffering
              ? const Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(color: Colors.red),
                  ),
                )
              : const SizedBox.shrink();
        });
  }

  Widget ForwardBackwardControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: double.infinity,
          child: GestureDetector(
              onDoubleTap: () =>
                  controllSeekTo(controller.value.position.inSeconds - 10),
              onVerticalDragUpdate: (details) {
                util.adjustSwipeBrightness(details.delta.dy);
              }),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: double.infinity,
          child: GestureDetector(
              onDoubleTap: () =>
                  controllSeekTo(controller.value.position.inSeconds + 10),
              onVerticalDragUpdate: (details) {
                ViewUtil.adjustSwipeVolume(details.delta.dy);
              }),
        ),
      ],
    );
  }

  void controllSeekTo(int duration) =>
      controller.seekTo(Duration(seconds: duration));
}
