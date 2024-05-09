class MovieStreamResponse {
  String? name;
  Data? data;

  MovieStreamResponse({this.name, this.data});

  MovieStreamResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? file;
  List<Sub>? sub;

  Data({this.file, this.sub});

  Data.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    if (json['sub'] != null) {
      sub = <Sub>[];
      json['sub'].forEach((v) {
        sub!.add(Sub.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    if (sub != null) {
      data['sub'] = sub!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sub {
  String? lang;
  String? file;

  Sub({this.lang, this.file});

  Sub.fromJson(Map<String, dynamic> json) {
    lang = json['lang'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lang'] = lang;
    data['file'] = file;
    return data;
  }
}
