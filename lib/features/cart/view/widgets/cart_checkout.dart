part of '../cart_screen.dart';

class _CartCheckout extends StatelessWidget {
  const _CartCheckout();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                '\$${cubit.subTotal.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 14),
          CustomButton(
            buttonText: 'Checkout',
            onPressed: () {
              cubit.checkOut(context: context);
            },
          ),
        ],
      ),
    );
  }
}
