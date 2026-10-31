import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/local/local_storage.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/service/seed_data_service.dart';
import 'package:shoply_app/features/splash/view_model/state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitState());

  void goNextPage() async {
    bool? isShowOnBoard = LocalStorage.instance.getShowOnBoard();
    // Both the local flag and a live Firebase session are needed.
    bool isLogin =
        (LocalStorage.instance.getIsLogin() ?? false) &&
        FirebaseAuth.instance.currentUser != null;

    await Future.delayed(Duration(seconds: 1)).then((value) async {
      if (isShowOnBoard ?? false) {
        if (isLogin) {
          await SeedDataService.seedIfNeeded();
          final responseLogin = await LocalStorageUser.instance.getUserData();
          LocalStorageUser.instance.setUserinfo(responseLogin: responseLogin);
          emit(SplashMainPageState());
        } else {
          emit(SplashLoginPageState());
        }
      } else {
        await LocalStorageUser.instance.clearUserData();
        emit(SplashOnBoardPageState());
      }
    });
  }
}
