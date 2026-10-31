import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/products/response_products.dart';

class FavoritesUsecase {
  CollectionReference<Map<String, dynamic>> get _favoritesRef =>
      FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('favorites');

  Future<Either<String, List<ResponseProducts>>> getFavorites() async {
    try {
      final snapshot = await _favoritesRef.get();
      final List<ResponseProducts> favoritesData = [];
      for (var product in snapshot.docs) {
        favoritesData.add(ResponseProducts.fromJson(product.data()));
      }
      return Right(favoritesData);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, bool>> addFavorite({
    required ResponseProducts product,
  }) async {
    try {
      await _favoritesRef.doc(product.id).set(product.toJson());
      return Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, bool>> removeFavorite({
    required String productId,
  }) async {
    try {
      await _favoritesRef.doc(productId).delete();
      return Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
