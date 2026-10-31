import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/usecase/profile/profile_usecase.dart';

class ChangePasswordRepo {
  final _profileUsecase = ProfileUsecase();

  Future<Either<String, bool>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await _profileUsecase.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
