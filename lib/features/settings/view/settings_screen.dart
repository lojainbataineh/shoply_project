import 'package:flutter/material.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/list_tile/custom_list_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Settings'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 14,
            children: [
              CustomListTile(
                isCard: true,
                showArrow: true,
                iconData: Icons.person_outline,
                title: 'Update Profile',
                onTap: () {
                  Navigator.pushNamed(context, AppPages.updateProfileScreen);
                },
              ),
              CustomListTile(
                isCard: true,
                showArrow: true,
                iconData: Icons.lock_outline,
                title: 'Update Password',
                onTap: () {
                  Navigator.pushNamed(context, AppPages.changePasswordScreen);
                },
              ),
              CustomListTile(
                isCard: true,
                showArrow: true,
                iconData: Icons.info_outline,
                title: 'About',
                onTap: () {
                  Navigator.pushNamed(context, AppPages.aboutScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
