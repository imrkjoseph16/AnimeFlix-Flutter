import 'package:anime_nation/app/util/default.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/streaming_link_response.dart';

class ViewUtil {
  static String extractGenres(List<String>? genres) {
    String textToDisplay = "";
    int itemCount = genres?.length ?? 0;

    for (var index = 0; index < itemCount; index++) {
      if (index == itemCount - 1) {
        textToDisplay += ("${genres?[index]}");
      } else {
        textToDisplay += ("${genres?[index]}, ");
      }
    }

    return textToDisplay;
  }

  static String? getBestQualityUrl(List<Sources>? source) {
    String? streamLink = "";
    int sized = source?.length ?? 0;
    for (var i = 0; i < sized; i++) {
      for (var type in QualityType.values) {
        if (source?[i].quality == type.value) {
          streamLink = source?[i].url;
          break;
        }
      }
    }
    return streamLink;
  }
}
