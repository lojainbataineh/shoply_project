part of '../../main_screen.dart';

class _MainBottomNavBar extends StatelessWidget {
  const _MainBottomNavBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      buildWhen: (previous, current) {
        return current is MainChangeNavBarIndexState ||
            current is MainChangeCartCountState;
      },
      builder: (context, state) {
        final cubit = context.read<MainCubit>();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(height: 1, thickness: 0.4, color: Colors.grey),
            NavigationBar(
              height: 70,
              selectedIndex: cubit.navBarIndex,
              onDestinationSelected: (index) {
                cubit.changeNavBarIndex(index: index);
              },
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.grid_view_outlined),
                  selectedIcon: Icon(Icons.grid_view_rounded),
                  label: 'Categories',
                ),
                NavigationDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
                NavigationDestination(
                  icon: Badge(
                    isLabelVisible: cubit.cartCount > 0,
                    backgroundColor: AppColors.primaryColor,
                    label: Text('${cubit.cartCount}'),
                    child: Icon(Icons.shopping_cart_outlined),
                  ),
                  selectedIcon: Badge(
                    isLabelVisible: cubit.cartCount > 0,
                    backgroundColor: AppColors.primaryColor,
                    label: Text('${cubit.cartCount}'),
                    child: Icon(Icons.shopping_cart),
                  ),
                  label: 'Cart',
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
