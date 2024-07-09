import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/core/di/injection.dart';
import 'package:instagram/core/state/state_status.dart';
import 'package:instagram/core/state/user_cubit.dart';
import 'package:instagram/core/utils/colors.dart';
import 'package:instagram/core/utils/utils.dart';
import 'package:instagram/core/widgets/text_field_input.dart';
import 'package:instagram/features/login/bloc/login_bloc.dart';
import 'package:instagram/features/login/bloc/login_event.dart';
import 'package:instagram/features/login/bloc/login_state.dart';
import 'package:instagram/gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc get _authBloc => getIt<LoginBloc>();
  UserCubit get _userCubit => getIt<UserCubit>();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    _authBloc
        .add(SigninEvent(_usernameController.text, _passwordController.text));
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => const HomeScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => _authBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              showSnackBar(context, state.error?.message ?? '');
            } else if (state.status.isSuccess) {
              final user = state.user;
              if (user != null) {
                _userCubit.isLoginUser(user);
              }
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      Assets.instagram.image(height: 84),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      TextFieldInput(
                        hintText: 'Enter your email',
                        textInputType: TextInputType.emailAddress,
                        textEditingController: _usernameController,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldInput(
                        hintText: 'Enter your password',
                        textInputType: TextInputType.text,
                        textEditingController: _passwordController,
                        isPass: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      InkWell(
                        onTap: state.status.isLoading ? null : loginUser,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(36)),
                            ),
                            color: blueColor,
                          ),
                          child: Text(
                            state.status.isLoading ? 'Loading' : 'Log in',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
