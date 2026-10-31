import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/order/products_order.dart';
import 'package:shoply_app/features/my_orders/repo/my_orders_repo.dart';
import 'package:shoply_app/features/my_orders/view_model/state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitState());
  final _myOrdersRepo = MyOrdersRepo();
  final List<ProductsOrder> responseOrders = [];
  final List<String> tabs = ['All', 'Active', 'Completed'];
  int tabIndex = 0;

  static const _completedStatuses = ['delivered', 'cancelled'];

  List<ProductsOrder> get filteredOrders {
    switch (tabIndex) {
      case 1:
        return responseOrders
            .where((order) => !_completedStatuses.contains(order.status))
            .toList();
      case 2:
        return responseOrders
            .where((order) => _completedStatuses.contains(order.status))
            .toList();
      default:
        return responseOrders;
    }
  }

  void changeTab({required int index}) {
    tabIndex = index;
    emit(MyOrdersChangeTabState());
  }

  Future<void> getMyOrders() async {
    responseOrders.clear();
    emit(MyOrdersLoadingState());
    final result = await _myOrdersRepo.getMyOrders();
    result.fold(
      (errorMessage) {
        emit(MyOrdersErrorState(errorMessage: errorMessage));
      },
      (responseOrders) {
        this.responseOrders.addAll(responseOrders);
        emit(MyOrdersSuccessState());
      },
    );
  }
}
