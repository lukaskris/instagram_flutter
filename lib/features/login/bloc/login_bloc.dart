import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram/core/repository/authentication_repository.dart';
import 'package:instagram/features/login/bloc/login_event.dart';
import 'package:instagram/features/login/bloc/login_state.dart';

@singleton
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginState()) {
    on<SigninEvent>(_onSignIn);
  }

  FutureOr<void> _onSignIn(event, emit) async {
    emit(state.asLoading());
    final response = await authRepository.login(event.email, event.password);
    if (response.isRight) {
      emit(state.asLoadSuccess(response.right!));
    } else {
      emit(state.asLoadFailure(response.left));
    }
  }
}
