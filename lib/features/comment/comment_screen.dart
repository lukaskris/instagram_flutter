import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram/core/di/injection.dart';
import 'package:instagram/core/utils/utils.dart';
import 'package:instagram/core/widgets/comment_card.dart';
import 'package:instagram/features/comment/bloc/comment_bloc.dart';

class CommentsScreen extends StatefulWidget {
  final int postId;
  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  CommentsScreenState createState() => CommentsScreenState();
}

class CommentsScreenState extends State<CommentsScreen> {
  CommentBloc get _commentBloc => getIt<CommentBloc>();

  final TextEditingController commentEditingController =
      TextEditingController();

  void postComment() async {
    _commentBloc.add(
        CommentEvent.postComment(widget.postId, commentEditingController.text));
  }

  @override
  void initState() {
    super.initState();
    commentEditingController.addListener(
      () {
        setState(() {});
      },
    );
    _commentBloc.add(CommentEvent.started(widget.postId));
  }

  @override
  void dispose() {
    GetIt.instance.resetLazySingleton<CommentBloc>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _commentBloc,
      child: BlocListener<CommentBloc, CommentState>(
        listenWhen: (previous, current) =>
            current.status.isFailurePostComment ||
            current.status.isFailurePostComment,
        listener: (context, state) {
          if (state.status.isFailurePostComment) {
            showSnackBar(
              context,
              state.error?.message ?? '',
            );
          } else if (state.status.isFailurePostComment) {
            commentEditingController.text = "";
            setState(() {});
          }
        },
        child: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Comments',
                ),
                centerTitle: false,
              ),
              body: _content(state),
              bottomNavigationBar: SafeArea(
                child: Container(
                  height: kToolbarHeight,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.user?.profilePicture ?? ''),
                        // "https://football-tribe.com/asia/wp-content/uploads/sites/8/2017/04/Shin-Tae-Yong-800x533.jpg"),
                        radius: 18,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 8),
                          child: TextField(
                            controller: commentEditingController,
                            decoration: InputDecoration(
                              hintText: 'Comment as ${state.user?.username}',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => commentEditingController.text.isEmpty
                            ? null
                            : postComment(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: const Text(
                            'Post',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _content(CommentState state) {
    if (state.status.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.status.isFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(state.error?.message ?? ''),
            TextButton(
              onPressed: () {
                _commentBloc.add(CommentEvent.started(widget.postId));
              },
              child: const Text('Try Again'),
            )
          ],
        ),
      );
    } else if (state.status.isSuccess ||
        state.status.isFailurePostComment ||
        state.status.isSuccessPostComment) {
      return ListView.builder(
        itemCount: state.comments.length,
        itemBuilder: (ctx, index) =>
            CommentCard(comment: state.comments[index]),
      );
    } else {
      return Container();
    }
  }
}
