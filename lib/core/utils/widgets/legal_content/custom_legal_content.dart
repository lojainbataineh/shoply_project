import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/icon_header/custom_icon_header.dart';

class LegalSection {
  final String title;
  final String body;

  const LegalSection({required this.title, required this.body});
}

/// Shared layout for the Privacy Policy and Terms & Conditions screens.
class CustomLegalContent extends StatelessWidget {
  const CustomLegalContent({
    super.key,
    required this.iconData,
    required this.title,
    required this.lastUpdated,
    required this.sections,
    required this.footer,
  });
  final IconData iconData;
  final String title;
  final String lastUpdated;
  final List<LegalSection> sections;
  final String footer;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
      children: [
        CustomIconHeader(
          iconData: iconData,
          title: title,
          subtitle: 'Last updated: $lastUpdated',
        ),
        SizedBox(height: 25),
        for (int index = 0; index < sections.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 26,
                  child: Text(
                    '${index + 1}.',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sections[index].title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        sections[index].body,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.45,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Divider(color: Colors.grey.shade300),
        SizedBox(height: 10),
        Text(
          footer,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
