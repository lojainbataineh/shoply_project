abstract class UpdateProfileState {}

class UpdateProfileInitState extends UpdateProfileState {}

class UpdateProfileLoadingState extends UpdateProfileState {}

class UpdateProfileErrorState extends UpdateProfileState {
  final String errorMessage;

  UpdateProfileErrorState({required this.errorMessage});
}

class UpdateProfileSuccessState extends UpdateProfileState {}

class UpdateProfilePickImageState extends UpdateProfileState {}
