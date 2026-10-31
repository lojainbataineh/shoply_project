part of '../forgot_password_screen.dart';

class _ForgotPasswordBottom extends StatelessWidget {
  const _ForgotPasswordBottom();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPassswordCubit>();
    return Column(
      children: [
        CustomTextField(
          validator: (email) {
            if (email?.trim().isEmpty ?? true) {
              return 'Email is required';
            } else if (AppRegex.emailRegex.hasMatch(email!.trim()) == false) {
              return 'Email is not valid';
            }
            return null;
          },
          controller: cubit.emailController,
          hinText: 'Email',
          prefixIcon: Icon(
            Icons.email_outlined,
            size: 24,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 15),
        CustomButton(
          buttonText: 'Send Reset Link',
          onPressed: () {
            cubit.forgotPassword();
          },
        ),
        SizedBox(height: 30),
        CustomTextButton(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppPages.loginScreen,
              (route) => false,
            );
          },
          textButton: 'Back to Login',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
