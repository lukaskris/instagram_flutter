import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/core/repository/authentication_repository.dart';
import 'package:instagram/features/login/bloc/login_event.dart';
import 'package:instagram/features/login/bloc/login_state.dart';

class AuthBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SigninEvent) {
      yield LoginLoading();
      try {
        final response =
            await authRepository.login(event.email, event.password);
        if (response != null) {
          yield LoginAuthenticated();
        }
      } catch (e) {
        yield LoginError(e.toString());
      }
    }
  }
}
