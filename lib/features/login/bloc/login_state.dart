import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instagram/core/models/failure.dart';
import 'package:instagram/core/models/user.dart';
import 'package:instagram/core/state/state_status.dart';
part 'login_state.freezed.dart';

@freezed
sealed class LoginState with _$LoginState {
  // Added constructor. Must not have any parameter
  const LoginState._();

  factory LoginState(
      {@Default(StateStatus.initial) StateStatus status,
      Failure? error,
      User? user}) = _LoginState;

  LoginState asLoading() {
    return copyWith(status: StateStatus.loading, error: null);
  }

  LoginState asLoadSuccess(User user) {
    return copyWith(status: StateStatus.success, error: null, user: user);
  }

  LoginState asLoadFailure(Failure exception) {
    return copyWith(status: StateStatus.failure, error: exception);
  }
}
