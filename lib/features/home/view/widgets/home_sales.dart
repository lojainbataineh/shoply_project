part of '../home_screen.dart';

class _HomeSales extends StatelessWidget {
  const _HomeSales();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final sales = cubit.responseSales;
    if (sales == null) return SizedBox.shrink();
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 12),
      height: 165,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    sales.title ?? '',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    sales.subtitle ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onPrimary.withValues(alpha: 0.9),
                    ),
                  ),
                  SizedBox(height: 14),
                  GestureDetector(
                    onTap: () {
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
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.onPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Shop Now',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: CustomCachedImageNetwork(
              height: 165,
              fit: BoxFit.contain,
              image: sales.image ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
