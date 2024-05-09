// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:anime_nation/app/util/default.dart';
import 'package:anime_nation/dashboard/shared/data/dto/movies/movies_details_response.dart';
import 'package:anime_nation/dashboard/shared/data/dto/movies/movies_response.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/dto/movie_stream_response.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class MoviesApiClient {
  final dio = Dio();

  Future<MoviesResponse?> getMoviesList(String queryName) async {
    var url = Uri.parse('${Default.MOVIES_BASE_URL}$queryName');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(json.jsonDecode(response.body));
    } else {
      return MoviesResponse();
    }
  }

  Future<MoviesDetailsResponse?> getMovieDetails(
      String detailsId, String typeOfMovie) async {
    var url = Uri.parse('${Default.MOVIES_BASE_URL}info/$detailsId');
    url = url.replace(queryParameters: <String, String>{'type': typeOfMovie});

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return MoviesDetailsResponse.fromJson(json.jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<MovieStreamResponse?> getStreamLink(
      String? parentId, int? season, int? episode) async {
    final params = <String, dynamic>{
      's': 1,
      'e': episode,
    };

    try {
      var response = await dio.get(
          '${Default.MOVIE_STREAM_ALTERNATIVE_BASE_URL}vidsrc/$parentId',
          queryParameters: params);

      if (response.statusCode == 200) {
        return MovieStreamResponse.fromJson(
            json.jsonDecode(json.jsonEncode(response.data))[0]);
      } else
        return null;
    } catch (e) {
      return null;
    }
  }
}
