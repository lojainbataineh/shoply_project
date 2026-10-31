part of '../forgot_password_screen.dart';

class _ForgotPasswordHeader extends StatelessWidget {
  const _ForgotPasswordHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondary,
          ),
          child: Icon(Icons.lock, size: 70, color: AppColors.primaryColor),
        ),
        SizedBox(height: 20),
        Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Enter your email and we\'ll send\nyou a reset link.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
