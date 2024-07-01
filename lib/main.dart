import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram/core/datasource/local_datasource.dart';
import 'package:instagram/core/datasource/remote_datasource.dart';
import 'package:instagram/core/network/network_service.dart';
import 'package:instagram/core/repository/authentication_repository.dart';
import 'package:instagram/features/login/bloc/login_bloc.dart';
import 'package:instagram/features/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

void setupDependencies() {
  GetIt.I.registerLazySingleton<NetworkService>(() => NetworkService());
  GetIt.I.registerLazySingleton<RemoteDatasource>(
      () => RemoteDatasource(networkService: GetIt.I<NetworkService>()));
  GetIt.I.registerLazySingleton<LocalDatasource>(() => LocalDatasource());
  GetIt.I.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: GetIt.I<RemoteDatasource>(),
        localDataSource: GetIt.I<LocalDatasource>(),
      ));

  GetIt.I.registerLazySingleton<AuthBloc>(
      () => AuthBloc(GetIt.I<AuthRepository>()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
