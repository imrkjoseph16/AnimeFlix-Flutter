import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/dashboard/shared/data/client/movies_api_client.dart';
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart';
import 'package:anime_nation/dashboard/shared/data/dao/list_full_data.dart';
import 'package:anime_nation/dashboard/shared/domain/transformer/shared_transformer.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/dao/stream_full_data.dart';

class MoviesRepository {
  MoviesApiClient movieApiClient = locator.get<MoviesApiClient>();
  SharedTransformer transformer = locator.get<SharedTransformer>();

  Future<ListFullData?> getMoviesList(String queryName) async {
    var response = await movieApiClient.getMoviesList(queryName);
    return transformer.transformMovieListResponse(response);
  }

  Future<DetailsFullData?> getMovieDetails(
      String detailsId, String typeOfMovie) async {
    var response = await movieApiClient.getMovieDetails(detailsId, typeOfMovie);
    return transformer.transformMovieDetailsResponse(response);
  }

  Future<StreamFullData?> getStreamLink(
      String? parentId, int? season, int? episode) async {
    var response =
        await movieApiClient.getStreamLink(parentId, season, episode);
    return transformer.transformMovieStreamResponse(response);
  }
}