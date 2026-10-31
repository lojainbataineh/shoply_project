import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/product_card/custom_product_card.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';
import 'package:shoply_app/features/main/view_model/state.dart';

/// Shown as a tab inside MainScreen. Favorites live in [MainCubit] so the
/// heart icons stay in sync on every screen.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      buildWhen: (previous, current) {
        return current is MainFavoritesChangedState ||
            current is MainFavoritesLoadingState;
      },
      builder: (context, state) {
        final cubit = context.read<MainCubit>();
        if (cubit.isFavoritesLoading && cubit.favorites.isEmpty) {
          return CustomLoadingData();
        }
        return CustomRefreshIndicator(
          onRefresh: () async {
            await cubit.getFavorites();
          },
          child: cubit.favorites.isEmpty
              ? EmptyScreen(
                  emptyText: 'No favorites yet.\nTap the heart on any product to save it here.',
                  iconData: Icons.favorite_border,
                )
              : GridView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: cubit.favorites.length,
                  padding: EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 265,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return CustomProductCard(
                      product: cubit.favorites[index],
                      showAddToCart: true,
                    );
                  },
                ),
        );
      },
    );
  }
}
