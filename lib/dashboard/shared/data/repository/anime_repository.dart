import 'package:anime_nation/dashboard/shared/data/client/anime_api_client.dart';
import 'package:anime_nation/dashboard/shared/data/dto/anime_details_response.dart';
import 'package:anime_nation/dashboard/shared/data/dto/anime_response.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/streaming_link_response.dart';

class SharedRepository {
  AnimeApiClient animeApiClient = AnimeApiClient();

  Future<AnimeResponse?> getAnimeList(String queryName) {
    return animeApiClient.getAnimeList(queryName);
  }

  Future<AnimeDetailsResponse?> getAnimeDetails(String detailsId) {
    return animeApiClient.getAnimeDetails(detailsId);
  }

  Future<StreamingLinkResponse?> getStreamLink(String? streamId) {
    return animeApiClient.getStreamLink(streamId);
  }
}
