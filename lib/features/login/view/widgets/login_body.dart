part of '../login_screen.dart';

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Column(
      children: [
        CustomTextField(
          validator: (email) {
            if (email?.trim().isEmpty ?? true) {
              return 'Email is required';
            } else if (!AppRegex.emailRegex.hasMatch(email!.trim())) {
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
        SizedBox(height: 4),
        CustomTextField(
          validator: (password) {
            if (password?.isEmpty ?? true) {
              return 'Password is required';
            }
            return null;
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
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppPages.forgotPasswordScreen);
          },
          child: Align(
            alignment: AlignmentGeometry.centerRight,
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
