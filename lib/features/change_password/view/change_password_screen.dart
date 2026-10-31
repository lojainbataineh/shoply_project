import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/regex/app_regex.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_dialog_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success_dialog.dart';
import 'package:shoply_app/core/utils/widgets/icon_header/custom_icon_header.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/textfield/custom_field_label.dart';
import 'package:shoply_app/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_app/features/change_password/view_model/cubit.dart';
import 'package:shoply_app/features/change_password/view_model/state.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        appBar: CustomAppBar(titleText: 'Change Password'),
        body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is ChangePasswordErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: 'Change Password',
                description: state.errorMessage,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is ChangePasswordSuccessState) {
              Navigator.pop(context);
              CustomSuccessDialog.showProSuccessDialog(
                context: context,
                title: 'Change Password',
                description: 'Your password was updated successfully.',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              );
            }
          },
          child: Builder(
            builder: (context) {
              final cubit = context.read<ChangePasswordCubit>();
              final lockIcon = Icon(
                Icons.lock_outline,
                color: Colors.grey.shade800,
              );
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        CustomIconHeader(
                          iconData: Icons.lock,
                          title: 'Keep your account secure',
                          subtitle: 'Update your password regularly\nto keep your account safe.',
                        ),
                        SizedBox(height: 25),
                        CustomFieldLabel(label: 'Current Password'),
                        CustomTextField(
                          validator: (password) {
                            if (password?.isEmpty ?? true) {
                              return 'Current Password is required';
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: cubit.currentPasswordController,
                          hinText: 'Current Password',
                          prefixIcon: lockIcon,
                        ),
                        CustomFieldLabel(label: 'New Password'),
                        CustomTextField(
                          validator: (password) {
                            if (password ==
                                cubit.currentPasswordController.text) {
                              return 'New password must be different';
                            }
                            return AppRegex.validatePassword(password);
                          },
                          obscureText: true,
                          controller: cubit.newPasswordController,
                          hinText: 'New Password',
                          prefixIcon: lockIcon,
                        ),
                        CustomFieldLabel(label: 'Confirm New Password'),
                        CustomTextField(
                          validator: (confirmPassword) {
                            if (confirmPassword?.isEmpty ?? true) {
                              return 'Confirm Password is required';
                            } else if (confirmPassword !=
                                cubit.newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: cubit.confirmPasswordController,
                          hinText: 'Confirm New Password',
                          prefixIcon: lockIcon,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            'Use at least 8 characters.',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          buttonText: 'Update Password',
                          onPressed: () {
                            cubit.changePassword();
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
