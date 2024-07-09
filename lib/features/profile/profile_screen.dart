import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/core/utils/colors.dart';
import 'package:instagram/features/setting/setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              topbar(context),
              headline(context),
              photos(),
            ],
          ),
        ),
      ),
    );
  }

  Padding photos() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GridView.builder(
        itemCount: 20,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(2),
            color: Colors.purple.shade200,
          );
        },
      ),
    );
  }

  Widget headline(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8, top: 8),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade500,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(2),
                        height: 80,
                        width: 80,
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
              ),
              const Expanded(
                child: Column(
                  children: [
                    Text("26",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("postingan", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  children: [
                    Text("26",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("pengikut", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  children: [
                    Text("26",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("mengikuti", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const Gap(4),
          const Text("Shin Tae Yong",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const Gap(4),
          const Text("Biodata disini :p")
        ],
      ),
    );
  }

  Padding topbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
      child: Row(children: [
        Text(
          "Shintaeyong1",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Flexible(child: Container()),
        IconButton(onPressed: () {}, icon: const Icon(Iconsax.add_square)),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ),
              );
            },
            icon: const Icon(Iconsax.setting)),
      ]),
    );
  }
}
