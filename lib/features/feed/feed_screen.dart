import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/core/di/injection.dart';
import 'package:instagram/core/state/state_status.dart';
import 'package:instagram/core/utils/colors.dart';
import 'package:instagram/core/widgets/post_card.dart';
import 'package:instagram/features/feed/bloc/feed_bloc.dart';
import 'package:instagram/features/feed/bloc/feed_event.dart';
import 'package:instagram/features/feed/bloc/feed_state.dart';
import 'package:instagram/gen/assets.gen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  FeedBloc get bloc => getIt<FeedBloc>();

  @override
  void initState() {
    super.initState();

    bloc.add(FeedLoadStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: SvgPicture.asset(
          Assets.icInstagram,
          height: 32,
        ),
        actions: [
          IconButton(
            icon: const Badge(
                child: Icon(
              Iconsax.heart,
            )),
            onPressed: () {},
          ),
          IconButton(
            icon: const Badge(
              label: Text("14"),
              child: Icon(
                Iconsax.message,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        bloc: bloc,
        builder: (context, state) {
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
                        bloc.add(FeedLoadStarted());
                      },
                      child: const Text('Try Again'))
                ],
              ),
            );
          } else if (state.status.isSuccess) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(FeedLoadStarted());
              },
              child: ListView.builder(
                itemCount: state.post.length + 1,
                itemBuilder: (ctx, index) => index == 0
                    ? _story()
                    : PostCard(
                        post: state.post[index - 1],
                        like: () {
                          bloc.add(LikeEvent(state.post[index - 1].postId));
                        },
                      ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _story() {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        itemCount: 12,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade500,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(2),
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  width: 3),
                              shape: BoxShape.circle),
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://football-tribe.com/asia/wp-content/uploads/sites/8/2017/04/Shin-Tae-Yong-800x533.jpg"),
                            backgroundColor: Colors.black,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: const Icon(
                              Iconsax.add_circle5,
                              color: blueColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(2),
                  const Text(
                    'Cerita Anda',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            );
          }

          return Container(
            padding: const EdgeInsets.all(8),
            width: 80,
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade400,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF833AB4),
                        Color(0xFFC13584),
                        Color(0xFFFCAF45)
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 2),
                        shape: BoxShape.circle),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://football-tribe.com/asia/wp-content/uploads/sites/8/2017/04/Shin-Tae-Yong-800x533.jpg"),
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
                const Gap(2),
                const Text(
                  'Shin Tae Yong asdasd ',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
