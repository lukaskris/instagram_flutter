part of 'comment_bloc.dart';

@freezed
sealed class CommentState with _$CommentState {
  // Added constructor. Must not have any parameter
  const CommentState._();

  factory CommentState({@Default(CommentStateStatus.initial) CommentStateStatus status, Failure? error, User? user, @Default([]) List<CommentService> comments}) = _CommentState;
  CommentState asLoading() {
    return copyWith(status: CommentStateStatus.loading, error: null);
  }

  CommentState asLoadSuccess(List<CommentService> comments, User? user) {
    return copyWith(status: CommentStateStatus.success, error: null, comments: comments, user: user);
  }

  CommentState asLoadFailure(Failure exception) {
    return copyWith(status: CommentStateStatus.failure, error: exception);
  }

  CommentState asSuccessPostComment(List<CommentService> comments) {
    return copyWith(status: CommentStateStatus.successPostComment, error: null, comments: comments);
  }

  CommentState asFailurePostComment(Failure exception) {
    return copyWith(status: CommentStateStatus.failurePostComment, error: exception);
  }
}

enum CommentStateStatus {
  initial,
  loading,
  success,
  failure,
  successPostComment,
  failurePostComment,
}



extension CommentStateStatusX on CommentStateStatus {
  bool get isLoading => this == CommentStateStatus.loading;
  bool get isSuccess => this == CommentStateStatus.success;
  bool get isFailure => this == CommentStateStatus.failure;
  bool get isSuccessPostComment => this == CommentStateStatus.successPostComment;
  bool get isFailurePostComment => this == CommentStateStatus.failurePostComment;
}
