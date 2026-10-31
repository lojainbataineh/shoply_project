import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class CustomIconHeader extends StatelessWidget {
  const CustomIconHeader({
    super.key,
    required this.iconData,
    required this.title,
    this.subtitle,
  });
  final IconData iconData;
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondary,
          ),
          child: Icon(iconData, size: 60, color: AppColors.primaryColor),
        ),
        SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }
}
