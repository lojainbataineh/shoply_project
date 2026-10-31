import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/features/products/repo/products_repo.dart';
import 'package:shoply_app/features/products/view_model/state.dart';

enum ProductsSortType { none, priceLowToHigh, priceHighToLow, nameAToZ }

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitState());

  final _productsRepo = ProductsRepo();
  final List<ResponseProducts> responseProducts = [];
  ProductsSortType sortType = ProductsSortType.none;

  Future<void> refreshProducts({required String? categoryId}) async {
    responseProducts.clear();
    await getProducts(categoryId: categoryId);
  }

  Future<void> getProducts({required String? categoryId}) async {
    emit(ProductsLoadingState());
    final result = await _productsRepo.getProducts(categoryId: categoryId);
    result.fold(
      (errorMessage) {
        emit(ProductsErrorState(errorMessage: errorMessage));
      },
      (responseProducts) {
        this.responseProducts.addAll(responseProducts);
        _applySort();
        emit(ProductsSuccessState());
      },
    );
  }

  void sortProducts({required ProductsSortType sortType}) {
    this.sortType = sortType;
    _applySort();
    emit(ProductsSortState());
  }

  void _applySort() {
    switch (sortType) {
      case ProductsSortType.priceLowToHigh:
        responseProducts.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
      case ProductsSortType.priceHighToLow:
        responseProducts.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
      case ProductsSortType.nameAToZ:
        responseProducts.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
      case ProductsSortType.none:
        break;
    }
  }
}
