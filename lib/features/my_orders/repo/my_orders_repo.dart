import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/order/products_order.dart';
import 'package:shoply_app/core/usecase/orders/orders_usecase.dart';

class MyOrdersRepo {
  final _ordersUsecase = OrdersUsecase();

  Future<Either<String, List<ProductsOrder>>> getMyOrders() async {
    return await _ordersUsecase.getMyOrders();
  }
}
