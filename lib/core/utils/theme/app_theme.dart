import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/fonts/app_fonts.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class AppTheme {
  static ThemeData themeLight = ThemeData(
    fontFamily: AppFonts.quikSand,
    scaffoldBackgroundColor: AppColors.backgrround,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgrround,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.black,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.backgrround,
      surfaceTintColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        return IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.primaryColor
              : Colors.grey.shade700,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: states.contains(WidgetState.selected)
              ? AppColors.primaryColor
              : Colors.grey.shade700,
        );
      }),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.backgrround,
      surfaceTintColor: Colors.transparent,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.primaryColor,
      onSecondary: AppColors.onPrimary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.backgrround,
      onSurface: Colors.black,
    ),
  );
}
