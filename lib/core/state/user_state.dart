part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserLogin extends UserState {
  final User user;

  UserLogin({required this.user});
}

class UserNotLogin extends UserState {
  UserNotLogin();
}
