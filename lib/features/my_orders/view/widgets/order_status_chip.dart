import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({super.key, required this.status});
  final String? status;
  @override
  Widget build(BuildContext context) {
    final isPending = status == 'pending' || status == null;
    final isCancelled = status == 'cancelled';
    final label = (status ?? 'pending').isEmpty
        ? 'Pending'
        : '${status![0].toUpperCase()}${status!.substring(1)}';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: isCancelled
            ? Colors.red.shade50
            : isPending
            ? AppColors.warningLight
            : AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: isCancelled
              ? Colors.red
              : isPending
              ? AppColors.warning
              : AppColors.primaryColor,
        ),
      ),
    );
  }
}
