import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/contact/request_contact.dart';
import 'package:shoply_app/features/contact_us/repo/contact_us_repo.dart';
import 'package:shoply_app/features/contact_us/view_model/state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitState());
  final _contactUsRepo = ContactUsRepo();
  final fullNameController = TextEditingController(
    text: LocalStorageUser.instance.fullName,
  );
  final emailController = TextEditingController(
    text: LocalStorageUser.instance.email,
  );
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  static const String supportEmail = 'support@shoply.example';

  final List<String> subjects = [
    'Order Issue',
    'Payment',
    'Shipping & Delivery',
    'Returns & Refunds',
    'Account',
    'Other',
  ];
  String? subject;

  void changeSubject({required String? subject}) {
    this.subject = subject;
    emit(ContactUsChangeSubjectState());
  }

  Future<void> sendMessage() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(ContactUsLoadingState());
      final result = await _contactUsRepo.sendMessage(
        requestContact: RequestContact(
          userUid: LocalStorageUser.instance.uid,
          fullName: fullNameController.text.trim(),
          email: emailController.text.trim(),
          subject: subject,
          message: messageController.text.trim(),
        ),
      );
      result.fold(
        (errorMessage) {
          emit(ContactUsErrorState(errorMessage: errorMessage));
        },
        (_) {
          emit(ContactUsSuccessState());
        },
      );
    }
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    emailController.dispose();
    messageController.dispose();
    return super.close();
  }
}
