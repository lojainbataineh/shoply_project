import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/usecase/cart/cart_usecase.dart';

class ProductDetailsRepo {
  final _cartUsecase = CartUsecase();

  Future<Either<String, bool>> addToCart({required Cart requestCart}) async {
    return await _cartUsecase.addToCart(requestCart: requestCart);
  }
}
