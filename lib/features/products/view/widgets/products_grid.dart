part of '../products_screen.dart';

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    return GridView.builder(
      itemCount: cubit.responseProducts.length,
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 220,
        crossAxisSpacing: 14,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return CustomProductCard(product: cubit.responseProducts[index]);
      },
    );
  }
}
