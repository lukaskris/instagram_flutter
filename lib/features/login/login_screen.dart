import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/core/utils/colors.dart';
import 'package:instagram/core/utils/utils.dart';
import 'package:instagram/core/widgets/text_field_input.dart';
import 'package:instagram/features/home/home_screen.dart';
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

  AuthBloc get _authBloc => context.read();

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
    // setState(() {
    //   _isLoading = true;
    // });
    // String res = await AuthMethods().loginUser(
    //     email: _emailController.text, password: _passwordController.text);
    // if (res == 'success') {
    //   if (context.mounted) {
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(
    //           builder: (context) => const ResponsiveLayout(
    //             mobileScreenLayout: MobileScreenLayout(),
    //             webScreenLayout: WebScreenLayout(),
    //           ),
    //         ),
    //         (route) => false);

    //     setState(() {
    //       _isLoading = false;
    //     });
    //   }
    // } else {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   if (context.mounted) {
    //     showSnackBar(context, res);
    //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            showSnackBar(context, state.message);
          } else if (state is LoginAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, LoginState>(
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
                      onTap: state is LoginLoading ? null : loginUser,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(36)),
                          ),
                          color: blueColor,
                        ),
                        child: const Text(
                          'Log in',
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
    );
  }
}
