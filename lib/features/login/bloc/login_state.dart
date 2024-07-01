abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginAuthenticated extends LoginState {}

class LoginUnAuthenticated extends LoginState {}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}
