part of '../signup_screen.dart';

class _SignupNameTextfield extends StatelessWidget {
  const _SignupNameTextfield();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return Column(
      children: [
        CustomTextField(
          validator: (fullName) {
            if (fullName?.trim().isEmpty ?? true) {
              return 'Full Name is required';
            }
            return null;
          },
          controller: cubit.fullNameController,
          hinText: 'Full Name',
          prefixIcon: Icon(
            Icons.person_outlined,
            size: 24,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4),
        CustomTextField(
          validator: (userName) {
            if (userName?.trim().isEmpty ?? true) {
              return 'Username is required';
            }
            return null;
          },
          controller: cubit.userNameController,
          hinText: 'Username',
          prefixIcon: Icon(
            Icons.person_outlined,
            size: 24,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}
