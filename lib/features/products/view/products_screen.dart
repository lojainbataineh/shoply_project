import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_app/core/utils/widgets/error_screen/error_screen.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/product_card/custom_product_card.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/features/products/view_model/cubit.dart';
import 'package:shoply_app/features/products/view_model/state.dart';
part 'widgets/products_grid.dart';
part 'widgets/products_sort_sheet.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
    required this.titleText,
    required this.categoryId,
  });
  final String titleText;

  /// Null shows the trending products.
  final String? categoryId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()..getProducts(categoryId: categoryId),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ProductsCubit>();
          return Scaffold(
            appBar: CustomAppBar(
              titleText: titleText,
              actions: [
                IconButton(
                  onPressed: () {
                    _ProductsSortSheet.show(context: context, cubit: cubit);
                  },
                  icon: Icon(Icons.filter_list, size: 26),
                ),
              ],
            ),
            body: BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoadingState) {
                  return CustomLoadingData();
                } else if (state is ProductsErrorState) {
                  return ErrorScreen(
                    errorMessage: state.errorMessage,
                    onRetry: () {
                      cubit.refreshProducts(categoryId: categoryId);
                    },
                  );
                }
                return CustomRefreshIndicator(
                  onRefresh: () async {
                    await cubit.refreshProducts(categoryId: categoryId);
                  },
                  child: cubit.responseProducts.isEmpty
                      ? EmptyScreen(
                          emptyText: 'No products in this category yet.',
                          iconData: Icons.inventory_2_outlined,
                        )
                      : _ProductsGrid(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
