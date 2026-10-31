part of '../../main_screen.dart';

class _MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MainAppBar();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainCubit>();
    if (cubit.navBarIndex != 0) {
      return CustomAppBar(
        titleText: cubit.pageTitles[cubit.navBarIndex],
        leading: IconButton(
          onPressed: () {
            cubit.changeNavBarIndex(index: 0);
          },
          icon: Icon(Icons.arrow_back_ios_new, size: 22),
        ),
      );
    }
    return CustomAppBar(
      title: Wrap(
        children: [
          Text(
            'Shop',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontStyle: FontStyle.normal,
            ),
          ),
          Text(
            'ly',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You have no new notifications.'),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          },
          icon: Icon(Icons.notifications_none_outlined, size: 27),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
