import 'package:flutter/material.dart';
import 'package:shoply_app/core/helper/date_helper.dart';
import 'package:shoply_app/core/model/order/products_order.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/features/my_orders/view/widgets/order_status_chip.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});
  final ProductsOrder order;

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    final greyStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.grey.shade600,
    );
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Order #${order.orderNumber}'),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    DateHelper.formatDate(order.createdAt),
                    style: greyStyle,
                  ),
                ),
                OrderStatusChip(status: order.status),
              ],
            ),
            SizedBox(height: 20),
            Text('Items', style: titleStyle),
            SizedBox(height: 10),
            for (final item in order.cart ?? [])
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomCachedImageNetwork(
                        height: 56,
                        width: 56,
                        fit: BoxFit.contain,
                        image: item.firstImage,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Qty: ${item.quantity ?? 0}  ×  \$${item.price?.toStringAsFixed(2) ?? ''}',
                            style: greyStyle,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${((item.price ?? 0) * (item.quantity ?? 0)).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            Divider(color: Colors.grey.shade300, height: 30),
            Text('Delivery', style: titleStyle),
            SizedBox(height: 8),
            Text(
              order.fullName ?? '',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 2),
            Text(order.address ?? '', style: greyStyle),
            Divider(color: Colors.grey.shade300, height: 30),
            Row(
              children: [
                Text('Total', style: titleStyle),
                Spacer(),
                Text(
                  '\$${order.subTotal?.toStringAsFixed(2) ?? ''}',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
