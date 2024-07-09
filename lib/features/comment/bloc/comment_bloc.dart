import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram/core/models/comment_service/comment_service.dart';
import 'package:instagram/core/models/failure.dart';
import 'package:instagram/core/models/user.dart';
import 'package:instagram/core/repository/authentication_repository.dart';
import 'package:instagram/core/repository/comment_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'comment_event.dart';
part 'comment_state.dart';
part 'comment_bloc.freezed.dart';

@lazySingleton
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;
  final AuthRepository authRepository;

  CommentBloc(this.commentRepository, this.authRepository) : super(_CommentState()) {
    on<_Started>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper));
      on<_PostComment>(
      _onPostComment,
      transformer: (events, mapper) => events.switchMap(mapper));
  }

  void _onLoadStarted(_Started event, Emitter<CommentState> emit) async {
    emit(state.asLoading());
    final user = await authRepository.getUser();
    final response = await commentRepository.getComments(event.postId);
    if (response.isRight) {
      emit(state.asLoadSuccess(response.right, user));
    } else {
      emit(state.asLoadFailure(response.left));
    }
  }

  void _onPostComment(_PostComment event, Emitter<CommentState> emit) async {
    emit(state.asLoading());
    final response = await commentRepository.sendComment(event.postId, event.message);
    if (response.isRight) {
      emit(state.asSuccessPostComment(state.comments + [response.right]));
    } else {
      emit(state.asFailurePostComment(response.left));
    }
  }
}
