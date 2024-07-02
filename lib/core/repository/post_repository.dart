import 'package:instagram/core/datasource/remote_datasource.dart';
import 'package:instagram/core/models/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
}

class PostRepositoryImpl extends PostRepository {
  RemoteDatasource remoteDatasource;
  PostRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Post>> getPosts() async {
    final post = await remoteDatasource.getPost();
    return post.map(
      (e) {
        return Post(
          datePublished: e.createdAt ?? DateTime.now(),
          description: e.content ?? '',
          likes: e.totalLikes ?? 0,
          postId: (e.postId ?? 0).toString(),
          profImage: '',
          postUrl: e.images?.firstOrNull ?? '',
          uid: '',
          username: e.likedByUser,
        );
      },
    ).toList();
  }
}
