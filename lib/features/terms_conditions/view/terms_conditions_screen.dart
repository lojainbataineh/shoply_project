import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/legal_content/custom_legal_content.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  static const _sections = [
    LegalSection(
      title: 'Using Your Account',
      body: 'Keep your account information accurate and your sign-in details secure.',
    ),
    LegalSection(
      title: 'Orders & Payments',
      body: 'Review prices, availability, and payment details before placing your order.',
    ),
    LegalSection(
      title: 'Shipping & Delivery',
      body: 'Delivery estimates and charges are shown during checkout.',
    ),
    LegalSection(
      title: 'Returns & Refunds',
      body: 'Review the return conditions provided with your order before requesting a return.',
    ),
    LegalSection(
      title: 'Contact Us',
      body: 'For questions, visit Contact Us in the app.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Terms & Conditions'),
      body: SafeArea(
        child: CustomLegalContent(
          iconData: Icons.description_outlined,
          title: 'Shopping with Shoply',
          lastUpdated: 'October 16, 2026',
          sections: _sections,
          footer: 'Sample terms for UI preview.',
        ),
      ),
    );
  }
}
