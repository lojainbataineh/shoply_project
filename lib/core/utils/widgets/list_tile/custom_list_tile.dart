import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.iconData,
    this.color,
    this.onTap,
    this.showArrow = false,
    this.isCard = false,
  });
  final String title;
  final IconData iconData;
  final Color? color;
  final void Function()? onTap;
  final bool showArrow;
  final bool isCard;
  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      leading: Icon(iconData, size: 26, color: color ?? Colors.black),
      trailing: showArrow
          ? Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black87)
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: color ?? Colors.black,
        ),
      ),
    );
    if (!isCard) return tile;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: tile,
    );
  }
}
