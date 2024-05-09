part of 'register_bloc.dart';

sealed class RegisterEvent {}

class RegisterDetailsEvent extends RegisterEvent {
  UserCredentials credentials;
  RegisterDetailsEvent({required this.credentials});
}

