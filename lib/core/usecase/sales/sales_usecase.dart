import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/sales/response_sales.dart';

class SalesUsecase {
  Future<Either<String, ResponseSales?>> getSales() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Sales')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return Right(null);
      }
      return Right(ResponseSales.fromJson(snapshot.docs.first.data()));
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
