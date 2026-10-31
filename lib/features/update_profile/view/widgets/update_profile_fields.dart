part of '../update_profile_screen.dart';

class _UpdateProfileFields extends StatelessWidget {
  const _UpdateProfileFields();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateProfileCubit>();
    return Column(
      children: [
        CustomFieldLabel(label: 'Full Name'),
        CustomTextField(
          validator: (fullName) {
            if (fullName?.trim().isEmpty ?? true) {
              return 'Full Name is required';
            }
            return null;
          },
          controller: cubit.fullNameController,
          hinText: 'Full Name',
          prefixIcon: Icon(Icons.person_outline, color: Colors.grey.shade800),
        ),
        CustomFieldLabel(label: 'Username'),
        CustomTextField(
          validator: (userName) {
            if (userName?.trim().isEmpty ?? true) {
              return 'Username is required';
            }
            return null;
          },
          controller: cubit.userNameController,
          hinText: 'Username',
          prefixIcon: Icon(Icons.person_outline, color: Colors.grey.shade800),
        ),
        CustomFieldLabel(label: 'Email'),
        CustomTextField(
          readOnly: true,
          controller: cubit.emailController,
          hinText: 'Email',
          prefixIcon: Icon(Icons.email_outlined, color: Colors.grey.shade800),
        ),
        CustomFieldLabel(label: 'Address'),
        CustomTextField(
          validator: (address) {
            if (address?.trim().isEmpty ?? true) {
              return 'Address is required';
            }
            return null;
          },
          controller: cubit.addressController,
          hinText: 'Address',
          prefixIcon: Icon(
            Icons.location_on_outlined,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}
