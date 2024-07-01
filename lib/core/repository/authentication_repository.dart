import 'package:instagram/core/datasource/local_datasource.dart';
import 'package:instagram/core/datasource/remote_datasource.dart';
import 'package:instagram/core/models/user.dart';

abstract class AuthRepository {
  Future<User?> login(String email, String password);
  Future<void> logout();
}

class AuthRepositoryImpl extends AuthRepository {
  final RemoteDatasource remoteDataSource;
  final LocalDatasource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User?> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      if (user != null) {
        await localDataSource.saveToken(user.token);
        return user; // Example user creation
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await localDataSource.clearToken();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
