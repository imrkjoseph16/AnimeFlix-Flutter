class KoreanStreamResponse {
  List<Sources>? sources;
  List<Subtitles>? subtitles;

  KoreanStreamResponse({this.sources, this.subtitles});

  KoreanStreamResponse.fromJson(Map<String, dynamic> json) {
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources!.add(Sources.fromJson(v));
      });
    }
    if (json['subtitles'] != null) {
      subtitles = <Subtitles>[];
      json['subtitles'].forEach((v) {
        subtitles!.add(Subtitles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sources != null) {
      data['sources'] = sources!.map((v) => v.toJson()).toList();
    }
    if (subtitles != null) {
      data['subtitles'] = subtitles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sources {
  String? url;
  bool? isM3U8;

  Sources({this.url, this.isM3U8});

  Sources.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    isM3U8 = json['isM3U8'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['isM3U8'] = isM3U8;
    return data;
  }
}

class Subtitles {
  String? url;
  String? lang;

  Subtitles({this.url, this.lang});

  Subtitles.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['lang'] = lang;
    return data;
  }
}
