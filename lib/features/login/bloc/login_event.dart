abstract class LoginEvent {}

class SigninEvent extends LoginEvent {
  final String email;
  final String password;

  SigninEvent(this.email, this.password);
}

class LogoutEvent extends LoginEvent {}
