import 'package:anime_nation/app/util/default.dart';
import 'package:anime_nation/dashboard/shared/data/dto/anime/anime_details_response.dart';
import 'package:anime_nation/dashboard/shared/data/dto/anime/anime_response.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/dto/anime_stream_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class AnimeApiClient {

  Future<AnimeResponse?> getAnimeList(String queryName) async {
    var url = Uri.parse('${Default.ANIME_BASE_URL}$queryName');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeResponse.fromJson(json.jsonDecode(response.body));
    } else {
      return AnimeResponse();
    }
  }

  Future<AnimeDetailsResponse?> getAnimeDetails(String detailsId) async {
    var url = Uri.parse('${Default.ANIME_BASE_URL}info/$detailsId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeDetailsResponse.fromJson(json.jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<AnimeStreamResponse?> getStreamLink(String? streamId) async {
    var url = Uri.parse('${Default.ANIME_BASE_URL}watch/$streamId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return AnimeStreamResponse.fromJson(json.jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
