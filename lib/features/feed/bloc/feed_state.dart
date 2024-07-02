import 'package:instagram/core/models/post.dart';

abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  List<Post> posts;
  FeedLoaded(this.posts);
}

class FeedError extends FeedState {
  final String message;

  FeedError(this.message);
}
