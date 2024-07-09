import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/features/addpost/add_post.dart';
import 'package:instagram/features/feed/feed_screen.dart';
import 'package:instagram/features/profile/profile_screen.dart';
import 'package:instagram/features/search/search_screen.dart';
import 'package:instagram/features/video/video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          FeedScreen(),
          SearchScreen(),
          SearchScreen(),
          VideoScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _index,
        enableFeedback: false,
        elevation: 0,
        onTap: (index) {
          if (index == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddPostScreen(),
              ),
            );
          }
          setState(() {
            if (index != 2) _index = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.home,
              ),
              activeIcon: Icon(Iconsax.home5),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              activeIcon: Icon(Icons.search_rounded),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.add_square),
              activeIcon: Icon(Iconsax.add5),
              label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.video),
              activeIcon: Icon(Iconsax.video5),
              label: "Video"),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.profile_circle),
              activeIcon: Icon(Iconsax.profile_circle5),
              label: "Profile"),
        ],
      ),
    );
  }
}
