part of '../product_details_screen.dart';

class _ProductDetailsTop extends StatelessWidget {
  const _ProductDetailsTop({required this.responseProducts});
  final ResponseProducts responseProducts;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    return Column(
      children: [
        Container(
          height: 280,
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: PageView.builder(
            controller: cubit.pageController,
            itemCount: responseProducts.images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: CustomCachedImageNetwork(
                  fit: BoxFit.contain,
                  image: responseProducts.images[index],
                ),
              );
            },
          ),
        ),
        if (responseProducts.images.length > 1) ...[
          SizedBox(height: 16),
          CustomSmoothIndicator(
            pageController: cubit.pageController,
            count: responseProducts.images.length,
          ),
        ],
      ],
    );
  }
}
