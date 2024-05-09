import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/dashboard/shared/data/client/anime_api_client.dart';
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart';
import 'package:anime_nation/dashboard/shared/data/dao/list_full_data.dart';
import 'package:anime_nation/dashboard/shared/domain/transformer/shared_transformer.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/dao/stream_full_data.dart';

class AnimeRepository {
  AnimeApiClient animeApiClient = locator.get<AnimeApiClient>();
  SharedTransformer transformer = locator.get<SharedTransformer>();

  Future<ListFullData?> getAnimeList(String queryName) async {
    var response = await animeApiClient.getAnimeList(queryName);
    return transformer.transformAnimeListResponse(response);
  }

  Future<DetailsFullData?> getAnimeDetails(String detailsId) async {
    var response = await animeApiClient.getAnimeDetails(detailsId);
    return transformer.transformAnimeDetailsResponse(response);
  }

  Future<StreamFullData?> getStreamLink(String? streamId) async {
    var response = await animeApiClient.getStreamLink(streamId);
    return transformer.transformAnimeStreamResponse(response);
  }
}
