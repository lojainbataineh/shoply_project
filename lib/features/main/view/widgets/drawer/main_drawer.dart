part of '../../main_screen.dart';

class _MainDrawer extends StatelessWidget {
  const _MainDrawer();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainCubit>();
    final user = LocalStorageUser.instance;
    return Drawer(
      width: 300,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                spacing: 12,
                children: [
                  SizedBox(width: 4),
                  ClipOval(
                    child: user.profileImage.isEmpty
                        ? Image(
                            image: AssetImage(AppImages.profilePicture),
                            height: 64,
                            width: 64,
                            fit: BoxFit.cover,
                          )
                        : CustomCachedImageNetwork(
                            height: 64,
                            width: 64,
                            errorWidget: Image(
                              image: AssetImage(AppImages.profilePicture),
                              fit: BoxFit.cover,
                            ),
                            image: user.profileImage,
                          ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(
                          user.fullName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          user.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(thickness: 0.4, color: Colors.grey.shade300),
              SizedBox(height: 10),
              CustomListTile(
                iconData: Icons.receipt_long_outlined,
                title: 'My Orders',
                onTap: () {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  navigator.pushNamed(AppPages.myOrdersScreen);
                },
              ),
              CustomListTile(
                iconData: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  navigator.pushNamed(AppPages.settingsScreen);
                },
              ),
              CustomListTile(
                iconData: Icons.info_outline,
                title: 'About',
                onTap: () {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  navigator.pushNamed(AppPages.aboutScreen);
                },
              ),
              Spacer(),
              CustomListTile(
                onTap: () {
                  CustomDialog.showCustomProDialog(
                    context: context,
                    title: 'Logout',
                    description: 'Are you sure you want to log out?',
                    dialogType: DialogType.error,
                    iconBackgroundColor: Colors.red,
                    iconColor: Colors.white,
                    icon: Icons.logout,
                    buttons: [
                      DialogButton(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      DialogButton(
                        text: 'Logout',
                        isPrimary: true,
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          await cubit.logout();
                          navigator.pushNamedAndRemoveUntil(
                            AppPages.loginScreen,
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
                iconData: Icons.logout,
                title: 'Logout',
                color: Colors.red,
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
