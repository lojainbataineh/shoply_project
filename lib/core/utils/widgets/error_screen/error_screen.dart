import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.errorMessage, this.onRetry});
  final String errorMessage;
  final void Function()? onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 60, color: AppColors.error),
            SizedBox(height: 15),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            if (onRetry != null) ...[
              SizedBox(height: 15),
              TextButton(
                onPressed: onRetry,
                child: Text(
                  'Try again',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
