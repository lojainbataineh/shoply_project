abstract class ChangePasswordState {}

class ChangePasswordInitState extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordErrorState extends ChangePasswordState {
  final String errorMessage;

  ChangePasswordErrorState({required this.errorMessage});
}

class ChangePasswordSuccessState extends ChangePasswordState {}
