import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/helper/image_picker_helper.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/user/request_update_profile.dart';
import 'package:shoply_app/features/update_profile/repo/update_profile_repo.dart';
import 'package:shoply_app/features/update_profile/view_model/state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitState());
  final _updateProfileRepo = UpdateProfileRepo();
  final fullNameController = TextEditingController(
    text: LocalStorageUser.instance.fullName,
  );
  final userNameController = TextEditingController(
    text: LocalStorageUser.instance.userName,
  );
  final emailController = TextEditingController(
    text: LocalStorageUser.instance.email,
  );
  final addressController = TextEditingController(
    text: LocalStorageUser.instance.address,
  );
  final formKey = GlobalKey<FormState>();

  File? image;

  String get profileImage => LocalStorageUser.instance.profileImage;

  Future<void> pickImage() async {
    final imageFile = await ImagePickerHelper.pickImageGallery();
    if (imageFile == null) return;
    image = File(imageFile.path);
    emit(UpdateProfilePickImageState());
  }

  Future<void> updateProfile() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(UpdateProfileLoadingState());
      final result = await _updateProfileRepo.updateProfile(
        image: image,
        requestUpdateProfile: RequestUpdateProfile(
          fullName: fullNameController.text.trim(),
          userName: userNameController.text.trim(),
          address: addressController.text.trim(),
        ),
      );
      await result.fold(
        (errorMessage) async {
          emit(UpdateProfileErrorState(errorMessage: errorMessage));
        },
        (imageUrl) async {
          await LocalStorageUser.instance.updateUserData(
            fullName: fullNameController.text.trim(),
            userName: userNameController.text.trim(),
            address: addressController.text.trim(),
            profileImage: imageUrl,
          );
          emit(UpdateProfileSuccessState());
        },
      );
    }
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    return super.close();
  }
}
