part of '../product_details_screen.dart';

class _ProductDetailsBody extends StatelessWidget {
  const _ProductDetailsBody({required this.responseProducts});
  final ResponseProducts responseProducts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            responseProducts.name ?? '',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Text(
                '\$${responseProducts.price?.toStringAsFixed(2) ?? ''}',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Spacer(),
              if (responseProducts.rating != null) ...[
                Icon(Icons.star_rounded, color: Colors.amber, size: 24),
                SizedBox(width: 4),
                Text(
                  '${responseProducts.rating}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  ' (${responseProducts.reviewsCount ?? 0})',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 14),
          Text(
            responseProducts.description ?? '',
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
