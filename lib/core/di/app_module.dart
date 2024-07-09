import 'package:injectable/injectable.dart';
import 'package:instagram/core/datasource/local_datasource.dart';
import 'package:instagram/core/datasource/remote_datasource.dart';
import 'package:instagram/core/network/network_service.dart';
import 'package:instagram/core/repository/authentication_repository.dart';
import 'package:instagram/core/repository/comment_repository.dart';
import 'package:instagram/core/repository/post_repository.dart';

@module
abstract class AppModule {
  @singleton
  NetworkService networkService() {
    return NetworkService();
  }

  @singleton
  RemoteDatasource remoteDatasource(NetworkService networkService) {
    return RemoteDatasource(networkService: networkService);
  }

  @singleton
  LocalDatasource localDataSource() {
    return LocalDatasource();
  }

  @singleton
  AuthRepository authRepository(
      RemoteDatasource remoteDatasource, LocalDatasource localDataSource) {
    return AuthRepositoryImpl(
        remoteDataSource: remoteDatasource, localDataSource: localDataSource);
  }

  @singleton
  PostRepository postRepository(
      RemoteDatasource remoteDatasource, LocalDatasource localDataSource) {
    return PostRepositoryImpl(remoteDatasource, localDataSource);
  }

  @singleton
  CommentRepository commentRepository(
      RemoteDatasource remoteDatasource, LocalDatasource localDataSource) {
    return CommentRepositoryImpl(remoteDatasource, localDataSource);
  }
}
