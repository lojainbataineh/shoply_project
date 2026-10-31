import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/helper/date_helper.dart';
import 'package:shoply_app/core/model/order/products_order.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_app/core/utils/widgets/error_screen/error_screen.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/features/my_orders/view/widgets/order_status_chip.dart';
import 'package:shoply_app/features/my_orders/view_model/cubit.dart';
import 'package:shoply_app/features/my_orders/view_model/state.dart';
part 'widgets/my_orders_tabs.dart';
part 'widgets/my_orders_card.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyOrdersCubit()..getMyOrders(),
      child: Scaffold(
        appBar: CustomAppBar(titleText: 'My Orders'),
        body: BlocBuilder<MyOrdersCubit, MyOrdersState>(
          builder: (context, state) {
            final cubit = context.read<MyOrdersCubit>();
            if (state is MyOrdersLoadingState) {
              return CustomLoadingData();
            } else if (state is MyOrdersErrorState) {
              return ErrorScreen(
                errorMessage: state.errorMessage,
                onRetry: () {
                  cubit.getMyOrders();
                },
              );
            }
            final orders = cubit.filteredOrders;
            return Column(
              children: [
                _MyOrdersTabs(),
                Expanded(
                  child: CustomRefreshIndicator(
                    onRefresh: () async {
                      await cubit.getMyOrders();
                    },
                    child: orders.isEmpty
                        ? EmptyScreen(
                            emptyText: 'No orders here yet.',
                            iconData: Icons.receipt_long_outlined,
                          )
                        : ListView.separated(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.all(16),
                            itemCount: orders.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 14);
                            },
                            itemBuilder: (context, index) {
                              return _MyOrdersCard(order: orders[index]);
                            },
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
