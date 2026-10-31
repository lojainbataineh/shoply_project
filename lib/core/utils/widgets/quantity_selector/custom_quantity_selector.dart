import 'package:flutter/material.dart';

class CustomQuantitySelector extends StatelessWidget {
  const CustomQuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.width,
    this.height,
  });
  final int quantity;
  final void Function() onIncrement;
  final void Function() onDecrement;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      width: width ?? 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onDecrement,
              child: Icon(Icons.remove, size: 20),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                quantity.toString(),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: onIncrement,
              child: Icon(Icons.add, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
