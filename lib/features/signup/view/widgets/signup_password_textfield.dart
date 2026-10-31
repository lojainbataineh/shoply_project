part of '../signup_screen.dart';

class _SignupPasswordTextfield extends StatelessWidget {
  const _SignupPasswordTextfield();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return Column(
      children: [
        CustomTextField(
          validator: (password) {
            return AppRegex.validatePassword(password);
          },
          obscureText: true,
          controller: cubit.passwordController,
          hinText: 'Password',
          prefixIcon: Icon(
            Icons.lock_outline,
            size: 24,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4),
        CustomTextField(
          validator: (confirmPassword) {
            if (confirmPassword?.isEmpty ?? true) {
              return 'Confirm Password is required';
            } else if (confirmPassword != cubit.passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          obscureText: true,
          controller: cubit.confirmPasswordController,
          hinText: 'Confirm Password',
          prefixIcon: Icon(
            Icons.lock_outline,
            size: 24,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}
