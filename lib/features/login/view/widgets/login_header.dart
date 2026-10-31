part of '../login_screen.dart';

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(AppImages.shoplySplashImage),
          height: 170,
          width: 210,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 10),
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        Text(
          'Sign in to continue shopping',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
