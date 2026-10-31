import 'package:flutter/material.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/routes/app_routes.dart';
import 'package:shoply_app/core/utils/theme/app_theme.dart';

class ShoplyApp extends StatelessWidget {
  const ShoplyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoply App',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppPages.splashScreen,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeLight,
    );
  }
}
