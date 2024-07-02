import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram/core/repository/authentication_repository.dart';
import 'package:instagram/features/login/bloc/login_event.dart';
import 'package:instagram/features/login/bloc/login_state.dart';

@injectable
class AuthBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(LoginInitial()) {
    on<SigninEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final response =
            await authRepository.login(event.email, event.password);
        if (response != null) {
          emit(LoginAuthenticated());
        }
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }
}
