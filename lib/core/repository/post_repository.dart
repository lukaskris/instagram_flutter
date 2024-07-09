import 'package:either_dart/either.dart';
import 'package:instagram/core/datasource/local_datasource.dart';
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
  LocalDatasource localDatasource;
  PostRepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    final result = await remoteDatasource.getPost();
    final profilePicture = await localDatasource.getProfilePicture() ?? '';
    final username = await localDatasource.getUsername() ?? '';
    if (result.isRight) {
      return Right(result.right
          .map((e) => Post(
              datePublished: e.createdAt ?? DateTime.now(),
              description: e.content ?? '',
              likes: e.totalLikes ?? 0,
              postId: (e.postId ?? 0),
              profImage: profilePicture,
              postUrl: NetworkService.baseUrl + (e.images?.firstOrNull ?? ''),
              uid: '',
              totalComments: e.totalComments ?? 0,
              username: username,
              isLike: e.likedByUser == 1))
          .toList());
    } else {
      return Left(result.left);
    }
  }

  @override
  Future<Either<Failure, Post>> likePost(String postId) async {
    final username = await localDatasource.getUsername() ?? '';
    final profilePicture = await localDatasource.getProfilePicture() ?? '';
    final result = await remoteDatasource.likePost(postId);
    if (result.isRight) {
      final e = result.right;
      return Right(Post(
          datePublished: e.createdAt ?? DateTime.now(),
          description: e.content ?? '',
          likes: e.totalLikes ?? 0,
          postId: (e.postId ?? 0),
          profImage: profilePicture,
          totalComments: e.totalComments ?? 0,
          postUrl: NetworkService.baseUrl + (e.images?.firstOrNull ?? ''),
          uid: '',
          username: username,
          isLike: e.likedByUser == 1));
    } else {
      return Left(result.left);
    }
  }
}
