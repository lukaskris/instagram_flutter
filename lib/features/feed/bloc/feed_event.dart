abstract class FeedEvent {}

class LikeEvent extends FeedEvent {
  final String postId;
  final bool isLiked;

  LikeEvent(this.postId, this.isLiked);
}
