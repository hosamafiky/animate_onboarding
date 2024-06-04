import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/onboard.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit()
      : super(
          const OnboardingInitial(
            onboards: [
              Onboard(
                title: 'Title 1',
                description: 'Description 1',
                imageUrl: 'https://picsum.photos/150',
                color: Colors.red,
              ),
              Onboard(
                title: 'Title 2',
                description: 'Description 2',
                imageUrl: 'https://picsum.photos/150',
                color: Colors.green,
              ),
              Onboard(
                title: 'Title 3',
                description: 'Description 3',
                imageUrl: 'https://picsum.photos/150',
                color: Colors.blue,
              ),
            ],
          ),
        );

  final pageController = PageController();

  void nextPage() {
    if (pageController.page == state.onboards.length - 1) return;
    pageController.nextPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  void previousPage() {
    pageController.previousPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  void onPageChanged(int index) {
    emit(CurrentIndexChanged(onboards: state.onboards, currentIndex: index));
  }
}
