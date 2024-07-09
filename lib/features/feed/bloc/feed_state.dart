import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instagram/core/models/failure.dart';
import 'package:instagram/core/models/post.dart';
import 'package:instagram/core/models/user.dart';
import 'package:instagram/core/state/state_status.dart';
part 'feed_state.freezed.dart';

@freezed
sealed class FeedState with _$FeedState {
  // Added constructor. Must not have any parameter
  const FeedState._();

  factory FeedState(
      {@Default(StateStatus.loading) StateStatus status,
      Failure? error,
      User? user,
      @Default([]) List<Post> post}) = _FeedState;
  FeedState asLoading() {
    return copyWith(status: StateStatus.loading, error: null);
  }

  FeedState asLoadSuccess(List<Post> post) {
    return copyWith(status: StateStatus.success, error: null, post: post);
  }

  FeedState asLoadFailure(Failure exception) {
    return copyWith(status: StateStatus.failure, error: exception);
  }
}
