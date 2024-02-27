import 'dart:convert' as json;

import 'package:anime_nation/dashboard/shared/data/dto/anime_details_response.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/streaming_link_response.dart';
import 'package:http/http.dart' as http;
import '../dto/anime_response.dart';

class AnimeApiClient {
  Future<AnimeResponse?> getAnimeList(String queryName) async {
    var url = Uri.parse(
        'https://anime-nation-server.vercel.app/meta/anilist/$queryName');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeResponse.fromJson(json.jsonDecode(response.body));
    } else {
      return AnimeResponse();
    }
  }

  Future<AnimeDetailsResponse?> getAnimeDetails(String detailsId) async {
    var url = Uri.parse(
        'https://anime-nation-server.vercel.app/meta/anilist/info/$detailsId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeDetailsResponse.fromJson(json.jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<StreamingLinkResponse?> getStreamLink(String? streamId) async {
    var url = Uri.parse(
        'https://anime-nation-server.vercel.app/meta/anilist/watch/$streamId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return StreamingLinkResponse.fromJson(json.jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
