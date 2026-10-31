part of '../categories_screen.dart';

class _CategoriesCard extends StatelessWidget {
  const _CategoriesCard();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoriesCubit>();
    return ListView.separated(
      padding: EdgeInsets.all(12),
      separatorBuilder: (context, index) {
        return SizedBox(height: 12);
      },
      itemCount: cubit.ressponseCategories.length,
      itemBuilder: (context, index) {
        final categoriesData = cubit.ressponseCategories[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppPages.productsScreen,
              arguments: {
                'titleText': categoriesData.name,
                'categoryId': categoriesData.id,
                'context': context,
              },
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CustomCachedImageNetwork(
                  height: 70,
                  width: 80,
                  fit: BoxFit.contain,
                  image: categoriesData.image ?? '',
                ),
                SizedBox(width: 16),
                Text(
                  categoriesData.name ?? '',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 18),
                SizedBox(width: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
