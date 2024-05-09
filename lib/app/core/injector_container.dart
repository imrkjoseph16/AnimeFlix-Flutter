import 'package:anime_nation/app/util/validation.dart';
import 'package:anime_nation/app/util/view_util.dart';
import 'package:anime_nation/dashboard/shared/data/client/anime_api_client.dart';
import 'package:anime_nation/dashboard/shared/data/client/korean_api_client.dart';
import 'package:anime_nation/dashboard/shared/data/client/movies_api_client.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/anime_repository.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/korean_repository.dart';
import 'package:anime_nation/dashboard/shared/domain/repository/movies_repository.dart';
import 'package:anime_nation/dashboard/shared/domain/transformer/shared_transformer.dart';
import 'package:anime_nation/shared/domain/firebase_repository.dart';
import 'package:anime_nation/shared/domain/firebase_auth_use_case.dart';
import 'package:anime_nation/shared/domain/firebase_shared_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton(() => AnimeRepository());
  locator.registerLazySingleton(() => AnimeApiClient());

  locator.registerLazySingleton(() => KoreanRepository());
  locator.registerLazySingleton(() => KoreanApiClient());

  locator.registerLazySingleton(() => MoviesRepository());
  locator.registerLazySingleton(() => MoviesApiClient());

  locator.registerLazySingleton(() => SharedTransformer());

  locator.registerLazySingleton(() => FirebaseRepository());
  locator.registerLazySingleton(() => FirebaseAuthUseCase());
  locator.registerLazySingleton(() => FirebaseSharedUseCase());

  locator.registerLazySingleton(() => ViewUtil());
  locator.registerLazySingleton(() => ValidationUtil());

  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
}
