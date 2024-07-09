import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram/core/models/post.dart';
import 'package:instagram/core/repository/post_repository.dart';
import 'package:instagram/features/feed/bloc/feed_event.dart';
import 'package:instagram/features/feed/bloc/feed_state.dart';
import 'package:stream_transform/stream_transform.dart';

@singleton
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository postRepository;

  FeedBloc(this.postRepository) : super(FeedState()) {
    on<FeedLoadStarted>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<LikeEvent>(_onLikePost,
        transformer: (events, mapper) => events.switchMap(mapper));
  }

  void _onLoadStarted(FeedLoadStarted event, Emitter<FeedState> emit) async {
    emit(state.asLoading());
    final response = await postRepository.getPosts();
    if (response.isRight) {
      emit(state.asLoadSuccess(response.right));
    } else {
      emit(state.asLoadFailure(response.left));
    }
  }

  void _onLikePost(LikeEvent event, Emitter<FeedState> emit) async {
    final response = await postRepository.likePost(event.postId.toString());
    if (response.isRight) {
      List<Post> oldPost = List.from(state.post);
      final index = oldPost.indexWhere((e) => e.postId == event.postId);
      oldPost[index] = response.right;
      emit(state.asLoadSuccess(oldPost));
    } else {
      emit(state.asLoadFailure(response.left));
    }
  }
}
