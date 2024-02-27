class StreamingLinkResponse {
  Headers? headers;
  List<Sources>? sources;
  String? download;

  StreamingLinkResponse({this.headers, this.sources, this.download});

  StreamingLinkResponse.fromJson(Map<String, dynamic> json) {
    headers =
        json['headers'] != null ? new Headers.fromJson(json['headers']) : null;
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources!.add(new Sources.fromJson(v));
      });
    }
    download = json['download'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.headers != null) {
      data['headers'] = this.headers!.toJson();
    }
    if (this.sources != null) {
      data['sources'] = this.sources!.map((v) => v.toJson()).toList();
    }
    data['download'] = this.download;
    return data;
  }
}

class Headers {
  String? referer;

  Headers({this.referer});

  Headers.fromJson(Map<String, dynamic> json) {
    referer = json['Referer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Referer'] = this.referer;
    return data;
  }
}

class Sources {
  String? url;
  bool? isM3U8;
  String? quality;

  Sources({this.url, this.isM3U8, this.quality});

  Sources.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    isM3U8 = json['isM3U8'];
    quality = json['quality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['isM3U8'] = this.isM3U8;
    data['quality'] = this.quality;
    return data;
  }
}
