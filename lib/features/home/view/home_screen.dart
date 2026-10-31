import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/error_screen/error_screen.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/product_card/custom_product_card.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/core/utils/widgets/view_all/custom_view_all.dart';
import 'package:shoply_app/features/home/view_model/cubit.dart';
import 'package:shoply_app/features/home/view_model/state.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';
part 'widgets/home_sales.dart';
part 'widgets/home_categories.dart';
part 'widgets/home_trending_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHome(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          if (state is HomeLoadingState) {
            return CustomLoadingData();
          } else if (state is HomeErrorState) {
            return ErrorScreen(
              errorMessage: state.errorMessage,
              onRetry: () {
                cubit.refreshData();
              },
            );
          }
          return CustomRefreshIndicator(
            onRefresh: () async {
              await cubit.refreshData();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  _HomeSales(),
                  SizedBox(height: 20),
                  _HomeCategories(),
                  SizedBox(height: 15),
                  _HomeTrendingProducts(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
