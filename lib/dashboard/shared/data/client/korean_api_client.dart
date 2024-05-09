import 'package:anime_nation/app/util/default.dart';
import 'package:anime_nation/dashboard/shared/data/dto/korean/korean_details_response.dart';
import 'package:anime_nation/dashboard/shared/data/dto/korean/korean_response.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/dto/korean_stream_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class KoreanApiClient {
  Future<KoreanResponse?> getKoreanList(String queryName) async {
    var url = Uri.parse('${Default.KOREAN_BASE_URL}$queryName');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return KoreanResponse.fromJson(json.jsonDecode(response.body));
    } else {
      return KoreanResponse();
    }
  }

  Future<KoreanDetailsResponse?> getKoreanDetails(String detailsId) async {
    var url = Uri.parse('${Default.KOREAN_BASE_URL}info');
    url = url.replace(queryParameters: <String, String>{'id': detailsId});

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return KoreanDetailsResponse.fromJson(json.jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<KoreanStreamResponse?> getStreamLink(String streamId) async {
    var url = Uri.parse('${Default.KOREAN_BASE_URL}watch');
    url = url.replace(queryParameters: <String, String>{
      'episodeId': streamId,
      'server': Default.DEFAULT_KOREAN_SERVER
    });

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return KoreanStreamResponse.fromJson(json.jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
