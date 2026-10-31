part of '../my_orders_screen.dart';

class _MyOrdersTabs extends StatelessWidget {
  const _MyOrdersTabs();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyOrdersCubit>();
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.fieldColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          for (int index = 0; index < cubit.tabs.length; index++)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  cubit.changeTab(index: index);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: cubit.tabIndex == index
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(
                    cubit.tabs[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: cubit.tabIndex == index
                          ? AppColors.onPrimary
                          : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
