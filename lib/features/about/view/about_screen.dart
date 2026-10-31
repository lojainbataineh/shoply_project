import 'package:flutter/material.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/list_tile/custom_list_tile.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String appVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'About'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox(height: 20),
            Image(image: AssetImage(AppImages.shoplySplashImage), height: 190),
            SizedBox(height: 4),
            Text(
              'Version $appVersion',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 14),
            Text(
              'Your everyday shopping\ncompanion.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 35),
            CustomListTile(
              isCard: true,
              showArrow: true,
              iconData: Icons.mail_outline,
              title: 'Contact Us',
              onTap: () {
                Navigator.pushNamed(context, AppPages.contactUsScreen);
              },
            ),
            SizedBox(height: 12),
            CustomListTile(
              isCard: true,
              showArrow: true,
              iconData: Icons.description_outlined,
              title: 'Privacy Policy',
              onTap: () {
                Navigator.pushNamed(context, AppPages.privacyPolicyScreen);
              },
            ),
            SizedBox(height: 12),
            CustomListTile(
              isCard: true,
              showArrow: true,
              iconData: Icons.shield_outlined,
              title: 'Terms & Conditions',
              onTap: () {
                Navigator.pushNamed(context, AppPages.termsConditionsScreen);
              },
            ),
            SizedBox(height: 50),
            Text(
              'Made for better shopping.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
