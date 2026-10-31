import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/user/request_update_profile.dart';
import 'package:shoply_app/core/usecase/profile/profile_usecase.dart';

class UpdateProfileRepo {
  final _profileUsecase = ProfileUsecase();

  Future<Either<String, String?>> updateProfile({
    required RequestUpdateProfile requestUpdateProfile,
    required File? image,
  }) async {
    return await _profileUsecase.updateProfile(
      requestUpdateProfile: requestUpdateProfile,
      image: image,
    );
  }
}
