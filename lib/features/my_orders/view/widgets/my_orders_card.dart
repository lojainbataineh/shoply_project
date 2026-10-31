part of '../my_orders_screen.dart';

class _MyOrdersCard extends StatelessWidget {
  const _MyOrdersCard({required this.order});
  final ProductsOrder order;

  @override
  Widget build(BuildContext context) {
    final firstItem = order.cart?.isNotEmpty ?? false
        ? order.cart!.first
        : null;
    final itemsCount = order.itemsCount;
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${order.orderNumber}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      DateHelper.formatDate(order.createdAt),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              OrderStatusChip(status: order.status),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomCachedImageNetwork(
                  height: 64,
                  width: 64,
                  fit: BoxFit.contain,
                  image: firstItem?.firstImage ?? '',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstItem?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '$itemsCount ${itemsCount == 1 ? 'item' : 'items'}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '\$${order.subTotal?.toStringAsFixed(2) ?? ''}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          CustomButton(
            height: 44,
            isOutlined: true,
            buttonText: 'View Details',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppPages.orderDetailsScreen,
                arguments: order,
              );
            },
          ),
        ],
      ),
    );
  }
}
