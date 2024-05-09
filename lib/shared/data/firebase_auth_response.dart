import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthResponse {
  User? user;
  String? error;
  FirebaseAuthResponse({this.user, this.error});
}
