import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/core/widgets/text_expandable.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with TickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _favoriteController;
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _videoController.play();
        setState(() {});
      });
    _favoriteController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
  _videoController.dispose();
    super.dispose();
  }

  // VideoPlayerController _videoController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.black87),
            height: double.infinity,
            width: double.infinity,
            child: _videoController.value.isInitialized
                ? Center(
                    child: AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController)),
                  )
                : Container(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return VideoProgressIndicator(
                  _videoController,
                  allowScrubbing: true,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://football-tribe.com/asia/wp-content/uploads/sites/8/2017/04/Shin-Tae-Yong-800x533.jpg"),
                                    backgroundColor: Colors.black,
                                    radius: 16,
                                  ),
                                  Gap(8),
                                  Text("Cuffed.dating",
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              Gap(10),
                              TextExpandable(
                                text:
                                    "Meet Christie and John, a couple who understand the importance of compromise and compatibility from their nearly 30 years of marriage. Christine's invaluable advice: you cannot change someone to create your \"ideal\" partner. Emphasizing growth over transformation.",
                                textStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(8),
                        Column(
                          children: [
                            // Icon(Iconsax.heart, color: Colors.white),
                            IconButton(
                              splashRadius: 24,
                              iconSize: 24,
                              onPressed: () {
                                if (_favoriteController.status ==
                                    AnimationStatus.dismissed) {
                                  _favoriteController.reset();
                                  _favoriteController.animateTo(0.6);
                                } else {
                                  _favoriteController.reverse();
                                }
                              },
                              icon: Lottie.asset(
                                Icons8.heart_color,
                                height: 24,
                                controller: _favoriteController,
                              ),
                            ),
                            const Gap(4),
                            const Text("Suka",
                                style: TextStyle(color: Colors.white)),
                            const Gap(24),
                            const Icon(Iconsax.message, color: Colors.white),
                            const Gap(4),
                            const Text("738",
                                style: TextStyle(color: Colors.white)),
                            const Gap(24),
                            const Icon(Iconsax.send_1, color: Colors.white),
                            const Gap(4),
                            const Text("57,9rb",
                                style: TextStyle(color: Colors.white)),
                          ],
                        )
                      ])
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
