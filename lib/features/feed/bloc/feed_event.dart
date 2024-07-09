abstract class FeedEvent {}

class FeedLoadStarted extends FeedEvent {}

class LikeEvent extends FeedEvent {
  final int postId;

  LikeEvent(this.postId);
}
