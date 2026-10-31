import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';
import 'package:shoply_app/features/product_details/repo/product_details_repo.dart';
import 'package:shoply_app/features/product_details/view_model/state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitState());
  final _productDetailsRepo = ProductDetailsRepo();
  final pageController = PageController();

  int quantity = 1;

  void incrementQuantity() {
    if (quantity < 10) {
      quantity++;
      emit(ProductDetailsChangeQuantityState());
    }
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      emit(ProductDetailsChangeQuantityState());
    }
  }

  Future<void> addToCart({
    required Cart requestCart,
    required BuildContext context,
  }) async {
    final mainCubit = context.read<MainCubit>();
    emit(ProductDetailsAddToCartLoadingState());
    final result = await _productDetailsRepo.addToCart(
      requestCart: requestCart,
    );

    result.fold(
      (errorMessage) {
        emit(ProductDetailsAddToCartErrorState(errorMessage: errorMessage));
      },
      (_) {
        mainCubit.getCartCount();
        emit(ProductDetailsAddToCartSuccessState());
      },
    );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
