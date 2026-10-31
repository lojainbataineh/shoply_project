import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_app/core/utils/widgets/error_screen/error_screen.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/features/categories/view_model/cubit.dart';
import 'package:shoply_app/features/categories/view_model/state.dart';
part 'widgets/categories_card.dart';

/// Shown as a tab inside MainScreen (the app bar comes from MainScreen).
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit()..getCategories(),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          final cubit = context.read<CategoriesCubit>();
          if (state is CategoriesLoadingState) {
            return CustomLoadingData();
          } else if (state is CategoriesErrorState) {
            return ErrorScreen(
              errorMessage: state.errorMessage,
              onRetry: () {
                cubit.refreshCategories();
              },
            );
          }
          return CustomRefreshIndicator(
            onRefresh: () async {
              await cubit.refreshCategories();
            },
            child: cubit.ressponseCategories.isEmpty
                ? EmptyScreen(
                    emptyText: 'No categories yet.',
                    iconData: Icons.grid_view_outlined,
                  )
                : _CategoriesCard(),
          );
        },
      ),
    );
  }
}
