import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/shared/data/firebase_auth_response.dart';
import 'package:anime_nation/shared/data/user_credentials.dart';
import 'package:anime_nation/shared/domain/firebase_repository.dart';

class FirebaseAuthUseCase {
  FirebaseRepository repository = locator.get<FirebaseRepository>();

  Future<FirebaseAuthResponse> signUpDetails(UserCredentials credentials) =>
      repository.signUpWithEmailAndPassword(credentials);

  Future<FirebaseAuthResponse> signInCredentials(UserCredentials credentials) =>
      repository.signInWithEmailAndPassword(credentials);
}
