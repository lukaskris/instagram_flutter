
import 'package:either_dart/either.dart';
import 'package:instagram/core/datasource/local_datasource.dart';
import 'package:instagram/core/datasource/remote_datasource.dart';
import 'package:instagram/core/models/comment_service/comment_service.dart';
import 'package:instagram/core/models/failure.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<CommentService>>> getComments(int postId);
  Future<Either<Failure, CommentService>> sendComment(int postId, String comment);
}

class CommentRepositoryImpl extends CommentRepository {
  RemoteDatasource remoteDatasource;
  LocalDatasource localDatasource;
  CommentRepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<Either<Failure, List<CommentService>>> getComments(int postId) {
    return remoteDatasource.getComments(postId);
  }

  @override
  Future<Either<Failure, CommentService>> sendComment(int postId, String comment) {
    return remoteDatasource.sendComment(postId, comment);
  }

}
