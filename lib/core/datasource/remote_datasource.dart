import 'package:either_dart/either.dart';
import 'package:instagram/core/models/comment_service/comment_service.dart';
import 'package:instagram/core/models/failure.dart';
import 'package:instagram/core/models/post_service/post_service.dart';
import 'package:instagram/core/models/user.dart';
import 'package:instagram/core/network/network_service.dart';

class RemoteDatasource {
  final NetworkService _networkService;

  RemoteDatasource({required NetworkService networkService})
      : _networkService = networkService;

  Future<Either<Failure, User?>> login(String email, String password) async {
    final result = await _networkService.login(email, password);
    if (result.isRight) {
      return Right(result.right.data);
    } else {
      return Left(result.left);
    }
  }

  Future<Either<Failure, List<PostService>>> getPost() async {
    final result = await _networkService.getPosts();
    if (result.isRight) {
      return Right(result.right.data);
    } else {
      return Left(result.left);
    }
  }

  Future<Either<Failure, PostService>> likePost(String postId) async {
    final result = await _networkService.likePost(postId);
    if (result.isRight) {
      return Right(result.right.data);
    } else {
      return Left(result.left);
    }
  }

  Future<Either<Failure, List<CommentService>>> getComments(int postId) async {
    final result = await _networkService.getComments(postId);
    if (result.isRight) {
      return Right(result.right.data);
    } else {
      return Left(result.left);
    }
  }

  Future<Either<Failure, CommentService>> sendComment(int postId, String text) async {
    final result = await _networkService.sendComment(postId, text);
    if (result.isRight) {
    final data = result.right.data;
      return Right(data.copyWith(
        profilePicture: NetworkService.baseUrl + (data.profilePicture ?? '')
      ));
    } else {
      return Left(result.left);
    }
  }
}
