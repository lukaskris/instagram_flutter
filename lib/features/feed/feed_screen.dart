import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/core/utils/colors.dart';
import 'package:instagram/core/widgets/post_card.dart';
import 'package:instagram/gen/assets.gen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
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
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (ctx, index) => index == 0 ? _story() : const PostCard(),
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