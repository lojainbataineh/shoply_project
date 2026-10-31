import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_app/core/helper/error_handle_helper.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/user/request_update_profile.dart';
import 'package:shoply_app/core/service/upload_image_service.dart';

class ProfileUsecase {
  Future<Either<String, String?>> updateProfile({
    required RequestUpdateProfile requestUpdateProfile,
    required File? image,
  }) async {
    try {
      String? imageUrl;
      if (image != null) {
        imageUrl = await UploadImageService.uplaodImage(imageFile: image);
        if (imageUrl == null) {
          return Left('Failed to upload profile image. Please try again.');
        }
      }

      final request = RequestUpdateProfile(
        fullName: requestUpdateProfile.fullName,
        userName: requestUpdateProfile.userName,
        address: requestUpdateProfile.address,
        profileImage: imageUrl,
      );

      await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .set(request.toJson(), SetOptions(merge: true));

      return Right(imageUrl);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, bool>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.email == null) {
        return Left('Your session has expired. Please login again.');
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      return Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(ErrorHandleHelper.getCustomErrorMessage(e.code));
    }
  }
}
