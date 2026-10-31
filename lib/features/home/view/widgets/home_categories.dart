part of '../home_screen.dart';

class _HomeCategories extends StatelessWidget {
  const _HomeCategories();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Column(
      children: [
        CustomViewAll(
          text: 'Categories',
          onTapViewAll: () {
            context.read<MainCubit>().changeNavBarIndex(index: 1);
          },
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 105,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(width: 12);
            },
            scrollDirection: Axis.horizontal,
            itemCount: cubit.ressponseCategories.length,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              final categoryData = cubit.ressponseCategories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppPages.productsScreen,
                    arguments: {
                      'titleText': categoryData.name,
                      'categoryId': categoryData.id,
                      'context': context,
                    },
                  );
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.cardColor,
                      ),
                      child: CustomCachedImageNetwork(
                        height: 60,
                        width: 60,
                        fit: BoxFit.contain,
                        image: categoryData.image ?? '',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      categoryData.name ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
