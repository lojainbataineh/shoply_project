import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';
import 'package:shoply_app/features/main/view_model/state.dart';

/// Product grid item with a favorite heart. Needs [MainCubit] above it.
class CustomProductCard extends StatelessWidget {
  const CustomProductCard({
    super.key,
    required this.product,
    this.showAddToCart = false,
  });
  final ResponseProducts product;
  final bool showAddToCart;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainCubit>();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppPages.productsDetailsScreen,
          arguments: {'responseProducts': product, 'context': context},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.cardColor,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomCachedImageNetwork(
                        fit: BoxFit.contain,
                        image: product.firstImage,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: BlocBuilder<MainCubit, MainState>(
                      buildWhen: (previous, current) {
                        return current is MainFavoritesChangedState;
                      },
                      builder: (context, state) {
                        final isFavorite = cubit.isFavorite(product.id);
                        return GestureDetector(
                          onTap: () {
                            cubit.toggleFavorite(product: product);
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 26,
                            color: isFavorite
                                ? AppColors.primaryColor
                                : Colors.black87,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            product.name ?? '',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2),
          Text(
            '\$${product.price?.toStringAsFixed(2) ?? ''}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          if (showAddToCart) ...[
            SizedBox(height: 8),
            SizedBox(
              height: 38,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cubit.addToCart(product: product, context: context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
