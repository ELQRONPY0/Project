import 'package:flutter/material.dart';

@immutable
abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingPageChanged extends OnBoardingState {}

class ChangeDotState extends OnBoardingState {}

class NextPageState extends OnBoardingState {}
