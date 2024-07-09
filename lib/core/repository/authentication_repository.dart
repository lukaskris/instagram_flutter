import 'package:either_dart/either.dart';
import 'package:instagram/core/datasource/local_datasource.dart';
import 'package:instagram/core/datasource/remote_datasource.dart';
import 'package:instagram/core/models/failure.dart';
import 'package:instagram/core/models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User?>> login(String email, String password);
  Future<void> logout();
  Future<User?> getUser();
}

class AuthRepositoryImpl extends AuthRepository {
  final RemoteDatasource remoteDataSource;
  final LocalDatasource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User?>> login(String email, String password) async {
    final result = await remoteDataSource.login(email, password);
    if (result.isRight) {
      final user = result.right;
      await localDataSource.saveToken(user!.token);
      await localDataSource.saveUser(user.profilePicture, user.username);
    }
    return result;
  }

  @override
  Future<void> logout() async {
    try {
      await localDataSource.logout();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<User?> getUser() async {
    final profilePicture = await localDataSource.getProfilePicture();
    final username = await localDataSource.getUsername();
    final token = await localDataSource.getToken();
    if (username == null || username.isEmpty) {
      return null;
    }
    return User(
        username: username,
        profilePicture: profilePicture ?? '',
        token: token ?? '',
        email: '',
        bio: '',
        followers: const [],
        following: const []);
  }
}
