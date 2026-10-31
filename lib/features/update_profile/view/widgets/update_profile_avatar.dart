part of '../update_profile_screen.dart';

class _UpdateProfileAvatar extends StatelessWidget {
  const _UpdateProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) {
        return current is UpdateProfilePickImageState;
      },
      builder: (context, state) {
        final cubit = context.read<UpdateProfileCubit>();
        Widget avatar;
        if (cubit.image != null) {
          avatar = Image.file(
            cubit.image!,
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          );
        } else if (cubit.profileImage.isNotEmpty) {
          avatar = CustomCachedImageNetwork(
            height: 120,
            width: 120,
            image: cubit.profileImage,
            errorWidget: Image(image: AssetImage(AppImages.profilePicture)),
          );
        } else {
          avatar = Image(
            image: AssetImage(AppImages.profilePicture),
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          );
        }
        return Stack(
          children: [
            ClipOval(child: avatar),
            Positioned(
              bottom: 2,
              right: 2,
              child: GestureDetector(
                onTap: () {
                  cubit.pickImage();
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
