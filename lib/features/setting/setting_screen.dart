import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/core/di/injection.dart';
import 'package:instagram/core/state/user_cubit.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  UserCubit get _userCubit => getIt<UserCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Who Can See Your Content'),
            ),
            ListTile(
              title: const Text('Privacy Account'),
              leading: const Icon(Iconsax.lock),
              trailing: const Icon(Iconsax.arrow_right),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () async {
                await _userCubit.logout();
              },
            ),
            ListTile(
              title: const Text('Close Friend'),
              leading: const Icon(Iconsax.lovely),
              trailing: const Icon(Iconsax.arrow_right),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () async {
                await _userCubit.logout();
              },
            ),
            const Divider(
              thickness: 4,
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              leading: const Icon(
                Iconsax.logout,
                color: Colors.red,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () async {
                await _userCubit.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
