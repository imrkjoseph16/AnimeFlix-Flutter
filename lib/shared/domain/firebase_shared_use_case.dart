import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/dashboard/shared/data/dao/list_full_data.dart';
import 'package:anime_nation/dashboard/shared/domain/transformer/shared_transformer.dart';
import 'package:anime_nation/shared/data/video_watched_details.dart';
import 'package:anime_nation/shared/domain/firebase_repository.dart';

class FirebaseSharedUseCase {
  FirebaseRepository repository = locator.get<FirebaseRepository>();
  SharedTransformer transformer = locator.get<SharedTransformer>();

  Future<void> saveWatchedDuration(VideoWatchedDetails details) =>
      repository.saveWatchedDuration(details);

  Stream<ListFullData?> geContinueWatchingList() {
    var response = repository.geContinueWatchingList();
    return transformer.transformContinueWatchListResponse(response);
  }

  Future<VideoWatchedDetails?> checkWatchedDuration(String detailsId) =>
      repository.checkWatchedDuration(detailsId);
}
