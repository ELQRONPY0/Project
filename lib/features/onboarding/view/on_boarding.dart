import 'package:ai_tumor_detect/core/constant/color.dart';
import 'package:ai_tumor_detect/core/utils/on_boarding_list.dart';
import 'package:ai_tumor_detect/features/onboarding/view_model/cubit/onboarding_cubit.dart';
import 'package:ai_tumor_detect/features/onboarding/view_model/cubit/onboarding_state.dart';
import 'package:ai_tumor_detect/features/auth/login/view/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<Future<ByteData>> _imagesFutures = [];

  @override
  void initState() {
    super.initState();

    for (var item in onboardingList) {
      _imagesFutures.add(rootBundle.load(item.image));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnBoardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = OnboardingCubit.get(context);
        return Scaffold(
          backgroundColor: const Color(0xffffffff),
          body: SafeArea(
            child: PageView.builder(
              controller: cubit.pageController,
              onPageChanged: (index) {
                cubit.onPageChanged(index);
              },
              physics: const BouncingScrollPhysics(),
              itemCount: onboardingList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    FutureBuilder<ByteData>(
                      future: _imagesFutures[index],
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image.memory(
                            snapshot.data!.buffer.asUint8List(),
                            key: ValueKey('gif_$index'),
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.40,
                            gaplessPlayback: true,
                          );
                        }
                        return const SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    // نقاط التنقل
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingList.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.only(right: 5),
                          height: cubit.currentIndex == i ? 20 : 18,
                          width: cubit.currentIndex == i ? 20 : 18,
                          decoration: BoxDecoration(
                            color: cubit.currentIndex == i
                                ? AppColor.darkBlue
                                : AppColor.lightBlue700,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    // العنوان
                    Text(
                      onboardingList[index].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkBlue,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // الوصف
                    Text(
                      onboardingList[index].description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColor.darkBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: MaterialButton(
                          onPressed: () {
                            if (cubit.currentIndex <
                                onboardingList.length - 1) {
                              cubit.nextPage();
                            } else {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            }
                          },
                          color: AppColor.primaryColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                              cubit.currentIndex == onboardingList.length - 1
                                  ? "Start Now"
                                  : "Next"),
                        ),
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
