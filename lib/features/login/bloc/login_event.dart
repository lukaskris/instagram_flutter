import 'package:equatable/equatable.dart';

abstract class LoginEvent {}

class SigninEvent extends LoginEvent with EquatableMixin {
  final String email;
  final String password;

  SigninEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends LoginEvent {}
