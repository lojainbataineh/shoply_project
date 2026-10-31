import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/usecase/cart/cart_usecase.dart';
import 'package:shoply_app/core/usecase/favorites/favorites_usecase.dart';
import 'package:shoply_app/core/usecase/logout/logout_usecase.dart';

class MainRepo {
  final _cartUsecase = CartUsecase();
  final _logoutUsecase = LogoutUsecase();
  final _favoritesUsecase = FavoritesUsecase();

  Future<Either<String, bool>> logout() async {
    return _logoutUsecase.logout();
  }

  Future<Either<String, int>> getCartCount() async {
    return _cartUsecase.getCartCount();
  }

  Future<Either<String, bool>> addToCart({required Cart requestCart}) async {
    return _cartUsecase.addToCart(requestCart: requestCart);
  }

  Future<Either<String, List<ResponseProducts>>> getFavorites() async {
    return _favoritesUsecase.getFavorites();
  }

  Future<Either<String, bool>> addFavorite({
    required ResponseProducts product,
  }) async {
    return _favoritesUsecase.addFavorite(product: product);
  }

  Future<Either<String, bool>> removeFavorite({
    required String productId,
  }) async {
    return _favoritesUsecase.removeFavorite(productId: productId);
  }
}
