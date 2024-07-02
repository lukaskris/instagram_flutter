import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram/core/repository/post_repository.dart';
import 'package:instagram/features/feed/bloc/feed_event.dart';
import 'package:instagram/features/feed/bloc/feed_state.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository postRepository;

  FeedBloc(this.postRepository) : super(FeedInitial());

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) async* {
    if (event is FeedInitial) {
      yield FeedLoading();
      try {
        final response = await postRepository.getPosts();
        yield FeedLoaded(response);
      } catch (e) {
        yield FeedError(e.toString());
      }
    }
  }
}
