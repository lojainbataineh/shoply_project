import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/features/change_password/repo/change_password_repo.dart';
import 'package:shoply_app/features/change_password/view_model/state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitState());
  final _changePasswordRepo = ChangePasswordRepo();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> changePassword() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(ChangePasswordLoadingState());
      final result = await _changePasswordRepo.changePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
      );
      result.fold(
        (errorMessage) {
          emit(ChangePasswordErrorState(errorMessage: errorMessage));
        },
        (_) {
          emit(ChangePasswordSuccessState());
        },
      );
    }
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
