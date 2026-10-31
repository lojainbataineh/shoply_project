import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/contact/request_contact.dart';
import 'package:shoply_app/core/usecase/contact/contact_usecase.dart';

class ContactUsRepo {
  final _contactUsecase = ContactUsecase();

  Future<Either<String, bool>> sendMessage({
    required RequestContact requestContact,
  }) async {
    return await _contactUsecase.sendMessage(requestContact: requestContact);
  }
}
