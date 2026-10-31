import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_dialog_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success_dialog.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/textfield/custom_field_label.dart';
import 'package:shoply_app/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_app/features/update_profile/view_model/cubit.dart';
import 'package:shoply_app/features/update_profile/view_model/state.dart';
part 'widgets/update_profile_avatar.dart';
part 'widgets/update_profile_fields.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProfileCubit(),
      child: Scaffold(
        appBar: CustomAppBar(titleText: 'Update Profile'),
        body: BlocListener<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is UpdateProfileErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: 'Update Profile',
                description: state.errorMessage,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is UpdateProfileSuccessState) {
              Navigator.pop(context);
              CustomSuccessDialog.showProSuccessDialog(
                context: context,
                title: 'Update Profile',
                description: 'Your profile was updated successfully.',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              );
            }
          },
          child: Builder(
            builder: (context) {
              final cubit = context.read<UpdateProfileCubit>();
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        _UpdateProfileAvatar(),
                        SizedBox(height: 25),
                        _UpdateProfileFields(),
                        SizedBox(height: 15),
                        CustomButton(
                          buttonText: 'Save Changes',
                          onPressed: () {
                            cubit.updateProfile();
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
