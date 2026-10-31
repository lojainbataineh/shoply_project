import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/local/local_storage.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/features/cart/view/cart_screen.dart';
import 'package:shoply_app/features/categories/view/categories_screen.dart';
import 'package:shoply_app/features/favorites/view/favorites_screen.dart';
import 'package:shoply_app/features/home/view/home_screen.dart';
import 'package:shoply_app/features/main/repo/main_repo.dart';
import 'package:shoply_app/features/main/view_model/state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitState());
  final _mainRepo = MainRepo();
  int navBarIndex = 0;
  int cartCount = 0;
  final List<ResponseProducts> favorites = [];
  bool isFavoritesLoading = false;

  List<Widget> page = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartScreen(),
  ];

  final List<String> pageTitles = [
    'Shoply',
    'Categories',
    'Favorites',
    'My Cart',
  ];

  void init() {
    getCartCount();
    getFavorites();
  }

  void changeNavBarIndex({required int index}) {
    navBarIndex = index;
    emit(MainChangeNavBarIndexState());
  }

  Future<void> getCartCount() async {
    final result = await _mainRepo.getCartCount();
    result.fold((_) {}, (cartCount) {
      this.cartCount = cartCount;
      emit(MainChangeCartCountState());
    });
  }

  Future<void> getFavorites() async {
    isFavoritesLoading = true;
    emit(MainFavoritesLoadingState());
    final result = await _mainRepo.getFavorites();
    isFavoritesLoading = false;
    result.fold((_) {}, (favorites) {
      this.favorites
        ..clear()
        ..addAll(favorites);
    });
    emit(MainFavoritesChangedState());
  }

  bool isFavorite(String? productId) {
    return favorites.any((product) => product.id == productId);
  }

  Future<void> toggleFavorite({required ResponseProducts product}) async {
    if (isFavorite(product.id)) {
      favorites.removeWhere((favorite) => favorite.id == product.id);
      emit(MainFavoritesChangedState());
      await _mainRepo.removeFavorite(productId: product.id ?? '');
    } else {
      favorites.add(product);
      emit(MainFavoritesChangedState());
      await _mainRepo.addFavorite(product: product);
    }
  }

  Future<void> addToCart({
    required ResponseProducts product,
    required BuildContext context,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    final result = await _mainRepo.addToCart(
      requestCart: Cart(
        id: product.id,
        name: product.name,
        price: product.price,
        quantity: 1,
        images: product.images,
      ),
    );
    result.fold(
      (errorMessage) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: AppColors.error,
          ),
        );
      },
      (_) {
        getCartCount();
        messenger.showSnackBar(
          SnackBar(
            content: Text('${product.name} added to cart'),
            backgroundColor: AppColors.primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  Future<void> logout() async {
    await LocalStorage.instance.setIsLogin(isLogin: false);
    await LocalStorageUser.instance.clearUserData();
    await _mainRepo.logout();
  }

  void decrementCartCount() {
    if (cartCount > 0) cartCount--;
    emit(MainChangeCartCountState());
  }

  void removeCartCount() {
    cartCount = 0;
    emit(MainChangeCartCountState());
  }
}
