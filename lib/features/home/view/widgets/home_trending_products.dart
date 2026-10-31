part of '../home_screen.dart';

class _HomeTrendingProducts extends StatelessWidget {
  const _HomeTrendingProducts();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Column(
      children: [
        CustomViewAll(
          text: 'Trending Products',
          onTapViewAll: () {
            Navigator.pushNamed(
              context,
              AppPages.productsScreen,
              arguments: {
                'titleText': 'Trending Products',
                'categoryId': null,
                'context': context,
              },
            );
          },
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cubit.responseProducts.length,
          padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 220,
            crossAxisSpacing: 14,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return CustomProductCard(product: cubit.responseProducts[index]);
          },
        ),
      ],
    );
  }
}
