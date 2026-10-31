abstract class ContactUsState {}

class ContactUsInitState extends ContactUsState {}

class ContactUsLoadingState extends ContactUsState {}

class ContactUsErrorState extends ContactUsState {
  final String errorMessage;

  ContactUsErrorState({required this.errorMessage});
}

class ContactUsSuccessState extends ContactUsState {}

class ContactUsChangeSubjectState extends ContactUsState {}
