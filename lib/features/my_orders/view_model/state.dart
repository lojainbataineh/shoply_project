abstract class MyOrdersState {}

class MyOrdersInitState extends MyOrdersState {}

class MyOrdersLoadingState extends MyOrdersState {}

class MyOrdersErrorState extends MyOrdersState {
  final String errorMessage;

  MyOrdersErrorState({required this.errorMessage});
}

class MyOrdersSuccessState extends MyOrdersState {}

class MyOrdersChangeTabState extends MyOrdersState {}
