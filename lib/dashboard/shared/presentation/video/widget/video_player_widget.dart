// ignore_for_file: non_constant_identifier_names

import 'package:anime_nation/dashboard/shared/presentation/video/video_streaming_page.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/widget/video_controller.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoStreamingArguments args;
  final String streamLink;

  const VideoPlayerWidget(
      {required this.args, required this.streamLink, super.key});
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;

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
    controller.play();
    AutoOrientation.landscapeAutoMode(forceSensor: true);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  void disposeComponents() {
    controller.pause();
    controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        AutoOrientation.portraitUpMode();
        return true;
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller)),
          CenterLoading(),
          ForwardBackwardControls(),
          VideoController(
              context: context,
              args: widget.args,
              streamLink: widget.streamLink,
              controller: controller),
        ],
      ),
    );
  }

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
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
                  ),
                )
              : const SizedBox.shrink();
        });
  }

  Widget ForwardBackwardControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onDoubleTap: () =>
              controllSeekTo(controller.value.position.inSeconds - 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: double.infinity,
          ),
        ),
        InkWell(
          onDoubleTap: () =>
              controllSeekTo(controller.value.position.inSeconds + 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: double.infinity,
          ),
        )
      ],
    );
  }

  void controllSeekTo(int duration) {
    controller.seekTo(Duration(seconds: duration));
  }
}
