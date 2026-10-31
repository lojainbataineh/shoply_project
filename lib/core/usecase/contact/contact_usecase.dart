import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/contact/request_contact.dart';

class ContactUsecase {
  Future<Either<String, bool>> sendMessage({
    required RequestContact requestContact,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('ContactMessages')
          .add(requestContact.toJson());
      return Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
