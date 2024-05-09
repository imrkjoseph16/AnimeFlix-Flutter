part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class SignInCompleted extends LoginState {}

class SignInError extends LoginState {
  String error;
  SignInError({required this.error});
}
