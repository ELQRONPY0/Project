import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(OnBoardingInitial());

  static OnboardingCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  final PageController pageController = PageController();

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void onPageChanged(int index) {
    currentIndex = index;
    emit(OnBoardingPageChanged());
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
