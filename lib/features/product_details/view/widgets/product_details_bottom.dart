part of '../product_details_screen.dart';

class _ProductDetailsBottom extends StatelessWidget {
  const _ProductDetailsBottom({required this.responseProducts});
  final ResponseProducts responseProducts;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            buildWhen: (previous, current) {
              return current is ProductDetailsChangeQuantityState;
            },
            builder: (context, state) {
              return CustomQuantitySelector(
                height: 46,
                width: 140,
                quantity: cubit.quantity,
                onIncrement: () {
                  cubit.incrementQuantity();
                },
                onDecrement: () {
                  cubit.decrementQuantity();
                },
              );
            },
          ),
          SizedBox(height: 25),
          CustomButton(
            buttonText: 'Add to Cart',
            onPressed: () {
              cubit.addToCart(
                context: context,
                requestCart: Cart(
                  id: responseProducts.id,
                  name: responseProducts.name,
                  price: responseProducts.price,
                  quantity: cubit.quantity,
                  images: responseProducts.images,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
