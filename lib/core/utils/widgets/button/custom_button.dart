import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    this.style,
    this.onPressed,
    this.height,
    this.isOutlined = false,
  });
  final String buttonText;
  final TextStyle? style;
  final void Function()? onPressed;
  final double? height;
  final bool isOutlined;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(14),
            side: isOutlined
                ? BorderSide(color: AppColors.primaryColor, width: 1.5)
                : BorderSide.none,
          ),
          backgroundColor: isOutlined
              ? AppColors.backgrround
              : AppColors.primaryColor,
        ),
        child: Text(
          buttonText,
          style:
              style ??
              TextStyle(
                fontSize: 18,
                color: isOutlined
                    ? AppColors.primaryColor
                    : AppColors.onPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
