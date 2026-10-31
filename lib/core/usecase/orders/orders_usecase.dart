import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/order/products_order.dart';

class OrdersUsecase {
  Future<Either<String, List<ProductsOrder>>> getMyOrders() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Order')
          .where('userUid', isEqualTo: LocalStorageUser.instance.uid)
          .get();

      final List<ProductsOrder> ordersData = [];
      for (var order in snapshot.docs) {
        ordersData.add(ProductsOrder.fromJson(order.data()));
      }
      // Sorted here instead of orderBy() so no composite index is needed.
      ordersData.sort((a, b) {
        final aDate = a.createdAt ?? DateTime(0);
        final bDate = b.createdAt ?? DateTime(0);
        return bDate.compareTo(aDate);
      });
      return Right(ordersData);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
