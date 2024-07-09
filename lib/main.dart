import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/core/di/injection.dart';
import 'package:instagram/core/state/user_cubit.dart';
import 'package:instagram/core/utils/language_manager.dart';
import 'package:instagram/features/home/home_screen.dart';
import 'package:instagram/features/login/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      supportedLocales: const [ENGLISH_LOCAL],
      localizationsDelegates: const [
        AppLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => getIt<UserCubit>(),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserNotLogin) {
              return const LoginScreen();
            } else {
              return const HomeScreen();
            }
          },
        ),
      ),
    );
  }
}
