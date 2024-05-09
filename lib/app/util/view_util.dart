import 'package:anime_nation/app/util/default.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/dao/stream_full_data.dart';
import 'package:flutter/services.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:screen_brightness/screen_brightness.dart';

class ViewUtil {
  String extractString(List<String>? stringList) {
    String textToDisplay = "";
    int itemCount = stringList?.length ?? 0;

    for (var index = 0; index < itemCount; index++) {
      if (index == itemCount - 1) {
        textToDisplay += ("${stringList?[index]}");
      } else {
        textToDisplay += ("${stringList?[index]}, ");
      }
    }

    return textToDisplay;
  }

  String getBestQualityUrl(List<Sources>? source) {
    String? streamLink;
    int sized = source?.length ?? 0;
    for (var i = 0; i < sized; i++) {
      for (var type in QualityType.values) {
        if (source?[i].quality == null) {
          streamLink = source?[0].url;
          break;
        } else if (source?[i].quality == type.value) {
          streamLink = source?[i].url;
          break;
        }
      }
    }
    return streamLink ?? "";
  }

  void adjustSwipeBrightness(double ySwipeAxis) async {
    double brightness = await ScreenBrightness().current;
    int sensitivity = 8;
    if (ySwipeAxis > sensitivity) {
      if (brightness > 0.1) {
        brightness = brightness - 0.1;
      }
    } else if (ySwipeAxis < -sensitivity) {
      if (brightness < 0.9) {
        brightness = brightness + 0.1;
      }
    }
    return ScreenBrightness().setScreenBrightness(brightness);
  }

  static void adjustSwipeVolume(double ySwipeAxis) async {
    double volume = await PerfectVolumeControl.volume;
    int sensitivity = 8;
    if (ySwipeAxis > sensitivity) {
      if (volume > 0.1) {
        volume = volume - 0.1;
      }
    } else if (ySwipeAxis < -sensitivity) {
      if (volume < 0.9) {
        volume = volume + 0.1;
      }
    }
    return PerfectVolumeControl.setVolume(volume);
  }

  void setPortraitMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void setLandccapeMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

 dynamic convertDuration(int millisSeconds) {
    var duration = Duration(milliseconds: millisSeconds.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
