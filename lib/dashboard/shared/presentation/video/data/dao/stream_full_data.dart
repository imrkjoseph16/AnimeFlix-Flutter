class StreamFullData {
  Headers? headers;
  List<Sources>? sources;
  List<Subtitles>? subtitles;
  String? download;

  StreamFullData({this.headers, this.sources, this.download, this.subtitles});
}

class Headers {
  String? referer;

  Headers({this.referer});
}

class Sources {
  String? url;
  bool? isM3U8;
  String? quality;

  Sources({this.url, this.isM3U8, this.quality});
}

class Subtitles {
  String? url;
  String? lang;

  Subtitles({this.url, this.lang});
}
