import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/features/login/view_model/state.dart';

import '../../../core/local/local_storage.dart';
import '../../../core/service/seed_data_service.dart';
import '../../../core/local/local_storage_user.dart';
import '../../../core/model/login/request_login.dart';
import '../repo/login_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  final _loginRepo = LoginRepo();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(LoginLoadingState());
      final result = await _loginRepo.login(
        requestLogin: RequestLogin(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );
      await result.fold(
        (errorMessage) async {
          emit(LoginErrorState(errorMessage: errorMessage));
        },
        (responseLogin) async {
          await SeedDataService.seedIfNeeded();
          await LocalStorage.instance.setIsLogin(isLogin: true);
          await LocalStorageUser.instance.setUserData(
            responseLogin: responseLogin,
          );
          LocalStorageUser.instance.setUserinfo(responseLogin: responseLogin);
          emit(LoginSuccessState());
        },
      );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
