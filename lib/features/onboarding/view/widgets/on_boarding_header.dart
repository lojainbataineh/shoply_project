part of '../on_boarding_screen.dart';

class _OnBoardingHeader extends StatelessWidget {
  const _OnBoardingHeader();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        buildWhen: (previous, current) {
          return current is! OnBoardingChangeIndexState;
        },
        builder: (context, state) {
          final cubit = context.read<OnBoardingCubit>();
          return PageView.builder(
            onPageChanged: (index) {
              cubit.changeIndex(index: index);
            },
            controller: cubit.pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(cubit.onBoardImage[index]),
                      height: 340,
                      width: double.infinity,
                    ),
                    SizedBox(height: 10),
                    Text(
                      cubit.onBoardTitle[index],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      cubit.onBoardDescreption[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
