import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_dialog_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success_dialog.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/quantity_selector/custom_quantity_selector.dart';
import 'package:shoply_app/core/utils/widgets/smooth_indicator/custom_smooth_indicator.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';
import 'package:shoply_app/features/main/view_model/state.dart';
import 'package:shoply_app/features/product_details/view_model/cubit.dart';
import 'package:shoply_app/features/product_details/view_model/state.dart';
part 'widgets/product_details_top.dart';
part 'widgets/product_details_body.dart';
part 'widgets/product_details_bottom.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.responseProducts});
  final ResponseProducts responseProducts;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            BlocBuilder<MainCubit, MainState>(
              buildWhen: (previous, current) {
                return current is MainFavoritesChangedState;
              },
              builder: (context, state) {
                final mainCubit = context.read<MainCubit>();
                final isFavorite = mainCubit.isFavorite(responseProducts.id);
                return IconButton(
                  onPressed: () {
                    mainCubit.toggleFavorite(product: responseProducts);
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 27,
                    color: isFavorite ? AppColors.primaryColor : Colors.black,
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocListener<ProductDetailsCubit, ProductDetailsState>(
          listenWhen: (previous, current) {
            return current is! ProductDetailsChangeQuantityState;
          },
          listener: (context, state) {
            if (state is ProductDetailsAddToCartLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is ProductDetailsAddToCartErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: 'Add to Cart',
                description: state.errorMessage,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is ProductDetailsAddToCartSuccessState) {
              Navigator.pop(context);
              CustomSuccessDialog.showProSuccessDialog(
                context: context,
                title: 'Add to Cart',
                description: 'Added to cart successfully.',
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProductDetailsTop(responseProducts: responseProducts),
                  SizedBox(height: 20),
                  _ProductDetailsBody(responseProducts: responseProducts),
                  SizedBox(height: 25),
                  _ProductDetailsBottom(responseProducts: responseProducts),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
