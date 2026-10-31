import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_app/core/helper/error_handle_helper.dart';

class ForgotPasswordUsecase {
  Future<Either<String, bool>> forgotPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(ErrorHandleHelper.getCustomErrorMessage(e.code));
    }
  }
}
