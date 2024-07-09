import 'package:either_dart/either.dart';
import 'package:instagram/core/datasource/remote_datasource.dart';
import 'package:instagram/core/models/failure.dart';
import 'package:instagram/core/models/post.dart';
import 'package:instagram/core/network/network_service.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, Post>> likePost(String postId);
}

class PostRepositoryImpl extends PostRepository {
  RemoteDatasource remoteDatasource;
  PostRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    final result = await remoteDatasource.getPost();
    if (result.isRight) {
      return Right(result.right
          .map((e) => Post(
              datePublished: e.createdAt ?? DateTime.now(),
              description: e.content ?? '',
              likes: e.totalLikes ?? 0,
              postId: (e.postId ?? 0),
              profImage: e.profilePicture ?? '',
              postUrl: NetworkService.baseUrl + (e.images?.firstOrNull ?? ''),
              uid: '',
              totalComments: e.totalComments ?? 0,
              username: e.username ?? '',
              isLike: e.likedByUser == 1))
          .toList());
    } else {
      return Left(result.left);
    }
  }

  @override
  Future<Either<Failure, Post>> likePost(String postId) async {
    final result = await remoteDatasource.likePost(postId);
    if (result.isRight) {
      final e = result.right;
      return Right(Post(
          datePublished: e.createdAt ?? DateTime.now(),
          description: e.content ?? '',
          likes: e.totalLikes ?? 0,
          postId: (e.postId ?? 0),
          profImage: e.profilePicture ?? '',
          totalComments: e.totalComments ?? 0,
          postUrl: NetworkService.baseUrl + (e.images?.firstOrNull ?? ''),
          uid: '',
          username: e.username ?? '',
          isLike: e.likedByUser == 1));
    } else {
      return Left(result.left);
    }
  }
}
