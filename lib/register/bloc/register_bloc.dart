import 'package:anime_nation/app/core/injector_container.dart';
import 'package:anime_nation/shared/data/firebase_auth_response.dart';
import 'package:anime_nation/shared/data/user_credentials.dart';
import 'package:anime_nation/shared/domain/firebase_auth_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  FirebaseAuthUseCase firebaseUseCase = locator.get<FirebaseAuthUseCase>();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterDetailsEvent>(_registerDetails);
  }

  Future<void> _registerDetails(
    RegisterDetailsEvent event,
    Emitter<RegisterState> emit,
  ) async {
    FirebaseAuthResponse result =
        await firebaseUseCase.signUpDetails(event.credentials);
    if (result.user?.uid != null) {
      emit(RegisterCompleted(user: result.user!));
    } else {
      emit(RegisterFailed(error: result.error!));
    }
  }
}
