import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class CustomViewAll extends StatelessWidget {
  const CustomViewAll({
    super.key,
    required this.text,
    required this.onTapViewAll,
  });
  final String text;
  final void Function() onTapViewAll;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: onTapViewAll,
            child: Text(
              'View All',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
