import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/legal_content/custom_legal_content.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const _sections = [
    LegalSection(
      title: 'Information We Collect',
      body: 'Account details, delivery addresses, and order information help us provide our services.',
    ),
    LegalSection(
      title: 'How We Use Information',
      body: 'We use information to manage your account, process orders, and respond to support requests.',
    ),
    LegalSection(
      title: 'Sharing Information',
      body: 'Service providers may receive the information needed to complete your order.',
    ),
    LegalSection(
      title: 'Your Choices',
      body: 'You can update your profile or contact us about your information.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Privacy Policy'),
      body: SafeArea(
        child: CustomLegalContent(
          iconData: Icons.verified_user_outlined,
          title: 'Your privacy matters',
          lastUpdated: 'October 16, 2026',
          sections: _sections,
          footer: 'Sample policy for UI preview.',
        ),
      ),
    );
  }
}
