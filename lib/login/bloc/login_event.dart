part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class SignInUserEvent extends LoginEvent {
  UserCredentials credentials;
  SignInUserEvent({required this.credentials});
}
