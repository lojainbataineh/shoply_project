import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.emptyText, this.iconData});
  final String emptyText;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    // Scrollable so it still works inside a RefreshIndicator.
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (iconData != null) ...[
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondary,
                        ),
                        child: Icon(
                          iconData,
                          size: 50,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                    Text(
                      emptyText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
