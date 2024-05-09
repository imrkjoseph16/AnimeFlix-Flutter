class MoviesResponse {
  int? currentPage;
  bool? hasNextPage;
  List<Results>? results;
  int? totalResults;
  int? totalPages;

  MoviesResponse(
      {this.currentPage,
      this.hasNextPage,
      this.results,
      this.totalResults,
      this.totalPages});

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    hasNextPage = json['hasNextPage'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalResults = json['totalResults'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['hasNextPage'] = hasNextPage;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['totalResults'] = totalResults;
    data['totalPages'] = totalPages;
    return data;
  }
}

class Results {
  late int id;
  String? title;
  String? image;
  String? type;
  num? rating;
  String? releaseDate;

  Results(
      {required this.id,
      this.title,
      this.image,
      this.type,
      this.rating,
      this.releaseDate});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    type = json['type'];
    rating = json['rating'];
    releaseDate = json['releaseDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['type'] = type;
    data['rating'] = rating;
    data['releaseDate'] = releaseDate;
    return data;
  }
}
