part of '../cart_screen.dart';

class _CartCard extends StatelessWidget {
  const _CartCard();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 8),
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: Colors.grey.shade200,
        );
      },
      itemCount: cubit.responseCart.length,
      itemBuilder: (context, index) {
        final cartData = cubit.responseCart[index];
        return Dismissible(
          key: ValueKey(cartData.id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            cubit.deleteProduct(productId: cartData.id ?? '', context: context);
          },
          background: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.red,
            alignment: AlignmentDirectional.centerEnd,
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 30,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: CustomCachedImageNetwork(
                    height: 80,
                    width: 80,
                    fit: BoxFit.contain,
                    image: cartData.firstImage,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartData.name ?? '',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${cartData.price?.toStringAsFixed(2) ?? ''}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomQuantitySelector(
                        height: 36,
                        width: 110,
                        quantity: cartData.quantity ?? 1,
                        onIncrement: () {
                          cubit.incrementQuantity(index: index);
                        },
                        onDecrement: () {
                          cubit.decrementQuantity(index: index);
                        },
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cubit.deleteProduct(
                      productId: cartData.id ?? '',
                      context: context,
                    );
                  },
                  icon: Icon(Icons.delete_outline, size: 26, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
