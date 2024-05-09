part of 'register_bloc.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class RegisterFailed extends RegisterState {
  String error;
  RegisterFailed({required this.error});
}

class RegisterCompleted extends RegisterState {
  User user;
  RegisterCompleted({required this.user});
}
