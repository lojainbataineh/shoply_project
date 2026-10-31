import 'package:flutter/material.dart';

class CustomFieldLabel extends StatelessWidget {
  const CustomFieldLabel({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 2),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade800,
          ),
        ),
      ),
    );
  }
}
