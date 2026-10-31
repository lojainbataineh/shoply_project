abstract class ProductDetailsState {}

class ProductDetailsInitState extends ProductDetailsState {}

class ProductDetailsChangeQuantityState extends ProductDetailsState {}

class ProductDetailsAddToCartLoadingState extends ProductDetailsState {}

class ProductDetailsAddToCartErrorState extends ProductDetailsState {
  final String errorMessage;

  ProductDetailsAddToCartErrorState({required this.errorMessage});
}

class ProductDetailsAddToCartSuccessState extends ProductDetailsState {}
