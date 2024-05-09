// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/app/util/default.dart';
import 'package:anime_nation/app/util/validation.dart';
import 'package:anime_nation/shared/data/firebase_auth_response.dart';
import 'package:anime_nation/shared/data/user_credentials.dart';
import 'package:anime_nation/shared/data/video_watched_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  final FirebaseFirestore _instance = locator.get<FirebaseFirestore>();
  final FirebaseAuth _auth = locator.get<FirebaseAuth>();
  final ValidationUtil util = locator.get<ValidationUtil>();

  Future<FirebaseAuthResponse> signUpWithEmailAndPassword(
      UserCredentials credentials) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: credentials.username, password: credentials.password);

      return saveFirestoreUserCreds(credentials, credential.user);
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthResponse(error: util.parseFirebaseErrorCode(e.code));
    }
  }

  Future<FirebaseAuthResponse> saveFirestoreUserCreds(
      UserCredentials details, User? credential) async {
    final userCollection = _instance
        .collection(Default.DEFAULT_USERS_DB)
        .doc(_auth.currentUser?.uid ?? "");

    await userCollection
        .set(details.toMap())
        .catchError((error) => print("Failed to save user details: $error"));

    return FirebaseAuthResponse(user: credential);
  }

  Future<FirebaseAuthResponse> signInWithEmailAndPassword(
      UserCredentials credentials) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: credentials.username, password: credentials.password);
      return FirebaseAuthResponse(user: credential.user);
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthResponse(error: util.parseFirebaseErrorCode(e.code));
    }
  }

  Future<void> saveWatchedDuration(VideoWatchedDetails details) async {
    final watchCollection = _instance
        .collection(Default.DEFAULT_USERS_DB)
        .doc(_auth.currentUser?.uid ?? "")
        .collection(Default.DEFAULT_UNFINISH_WATCH_DB)
        .doc(details.id.replaceAll("/", "-"));

    await watchCollection.set(details.toMap()).catchError(
        (error) => print("Failed to save watched duration: $error"));
  }

  Stream<List<VideoWatchedDetails>?> geContinueWatchingList() => _instance
          .collection(Default.DEFAULT_USERS_DB)
          .doc(_auth.currentUser?.uid ?? "")
          .collection(Default.DEFAULT_UNFINISH_WATCH_DB)
          .orderBy('lastDateWatched', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => VideoWatchedDetails.fromMap(doc.data()))
            .toList();
      });

  Future<VideoWatchedDetails?> checkWatchedDuration(String detailsId) async {
    try {
      VideoWatchedDetails? details;
      final watchInstance = await _instance
          .collection(Default.DEFAULT_USERS_DB)
          .doc(_auth.currentUser?.uid ?? "")
          .collection(Default.DEFAULT_UNFINISH_WATCH_DB)
          .doc(detailsId)
          .get();

      details = VideoWatchedDetails.fromMap(watchInstance.data()!);
      return details;
    } catch (e) {
      return null;
    }
  }
}
