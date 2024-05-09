// ignore_for_file: depend_on_referenced_packages

import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/shared/data/firebase_auth_response.dart';
import 'package:anime_nation/shared/data/user_credentials.dart';
import 'package:anime_nation/shared/domain/firebase_auth_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseAuthUseCase firebaseUseCase = locator.get<FirebaseAuthUseCase>();

  LoginBloc() : super(LoginInitial()) {
    on<SignInUserEvent>(_signInUser);
  }

  Future<void> _signInUser(
    SignInUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    FirebaseAuthResponse result =
        await firebaseUseCase.signInCredentials(event.credentials);
    if (result.error == null) {
      emit(SignInCompleted());
    } else {
      emit(SignInError(error: result.error!));
    }
  }
}
