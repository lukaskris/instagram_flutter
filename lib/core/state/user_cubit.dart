import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram/core/models/user.dart';
import 'package:instagram/core/repository/authentication_repository.dart';

part 'user_state.dart';

@singleton
class UserCubit extends Cubit<UserState> {
  AuthRepository authRepository;
  UserCubit(this.authRepository) : super(UserNotLogin()) {
    authRepository.getUser().then(
      (value) {
        isLoginUser(value);
      },
    );
  }
  bool _isLogin = false;
  bool get isLogin => _isLogin;

  void isLoginUser(User? user) {
    _isLogin = !_isLogin;
    if (_isLogin && user != null) {
      emit(UserLogin(user: user));
    } else {
      emit(UserNotLogin());
    }
  }

  Future<void> logout() async {
    _isLogin = !_isLogin;
    await authRepository.logout();
    emit(UserNotLogin());
  }
}
