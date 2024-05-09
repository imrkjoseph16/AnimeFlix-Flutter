import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/dashboard/shared/data/client/korean_api_client.dart';
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart';
import 'package:anime_nation/dashboard/shared/data/dao/list_full_data.dart';
import 'package:anime_nation/dashboard/shared/domain/transformer/shared_transformer.dart';
import 'package:anime_nation/dashboard/shared/presentation/video/data/dao/stream_full_data.dart';

class KoreanRepository {
  KoreanApiClient koreanApiClient = locator.get<KoreanApiClient>();
  SharedTransformer transformer = locator.get<SharedTransformer>();

  Future<ListFullData?> getKoreanList(String queryName) async {
    var response = await koreanApiClient.getKoreanList(queryName);
    return transformer.transformKoreanListResponse(response);
  }

  Future<DetailsFullData?> getKoreanDetails(String detailsId) async {
    var response = await koreanApiClient.getKoreanDetails(detailsId);
    return transformer.transformKoreanDetailsResponse(response);
  }

  Future<StreamFullData?> getStreamLink(String streamId) async {
    var response = await koreanApiClient.getStreamLink(streamId);
    return transformer.transformKoreanStreamResponse(response);
  }
}
