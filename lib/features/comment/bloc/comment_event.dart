part of 'comment_bloc.dart';

@freezed
class CommentEvent with _$CommentEvent {
  const factory CommentEvent.started(int postId) = _Started;
  const factory CommentEvent.postComment(int postId, String message) = _PostComment;
}
