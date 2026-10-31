import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_app/core/helper/error_handle_helper.dart';
import 'package:shoply_app/core/model/login/request_login.dart';
import 'package:shoply_app/core/model/login/response_login.dart';

class LoginUsecase {
  Future<Either<String, ResponseLogin>> login({
    required RequestLogin requestLogin,
  }) async {
    try {
      final snapshot = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: requestLogin.email ?? '',
        password: requestLogin.password ?? '',
      );

      final user = snapshot.user;

      if (!user!.emailVerified) {
        try {
          await user.sendEmailVerification();
        } on FirebaseAuthException catch (_) {
          // Ignore (e.g. too-many-requests): the user still has the old link.
        }
        await FirebaseAuth.instance.signOut();
        return Left(
          'Please verify your email first, then login. Check your inbox for the verification link.',
        );
      } else {
        return await _getUserinfo(uid: user.uid);
      }
    } on FirebaseAuthException catch (e) {
      final error = ErrorHandleHelper.getCustomErrorMessage(e.code);
      return Left(error);
    }
  }

  Future<Either<String, ResponseLogin>> _getUserinfo({
    required String uid,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .get();

      final responseLogin = ResponseLogin.fromJson(snapshot.data() ?? {});

      return Right(responseLogin);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
