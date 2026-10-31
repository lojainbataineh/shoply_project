part of '../products_screen.dart';

class _ProductsSortSheet extends StatelessWidget {
  const _ProductsSortSheet({required this.cubit});
  final ProductsCubit cubit;

  static void show({
    required BuildContext context,
    required ProductsCubit cubit,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgrround,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return _ProductsSortSheet(cubit: cubit);
      },
    );
  }

  static const _options = {
    ProductsSortType.none: 'Default',
    ProductsSortType.priceLowToHigh: 'Price: Low to High',
    ProductsSortType.priceHighToLow: 'Price: High to Low',
    ProductsSortType.nameAToZ: 'Name: A to Z',
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort by',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            for (final option in _options.entries)
              ListTile(
                onTap: () {
                  cubit.sortProducts(sortType: option.key);
                  Navigator.pop(context);
                },
                title: Text(
                  option.value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: cubit.sortType == option.key
                    ? Icon(Icons.check, color: AppColors.primaryColor)
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
