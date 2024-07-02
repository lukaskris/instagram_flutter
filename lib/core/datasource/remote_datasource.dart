import 'package:instagram/core/models/post_service/post_service.dart';
import 'package:instagram/core/models/user.dart';
import 'package:instagram/core/network/network_service.dart';

class RemoteDatasource {
  final NetworkService _networkService;

  RemoteDatasource({required NetworkService networkService})
      : _networkService = networkService;

  Future<User?> login(String email, String password) async {
    final result = await _networkService.login(email, password);
    return result.data;
  }

  Future<List<PostService>> getPost() async {
    final result = await _networkService.getPosts();
    return result.data;
  }
}
