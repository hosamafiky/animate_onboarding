import 'dart:developer';

import 'package:animate_onboarding/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:animate_onboarding/features/onboarding/presentation/widgets/onboarding_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Color _currentColor;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      reverseDuration: Duration.zero,
    );

    final cubit = BlocProvider.of<OnboardingCubit>(context);
    _currentColor = cubit.state.onboards[cubit.state.currentIndex].color;

    _scaleAnimation = Tween<double>(begin: 0, end: 100).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          log("Animation forward");
          _currentColor = cubit.state.onboards[(cubit.state.currentIndex + 1) % 3].color;
        }
        if (status == AnimationStatus.reverse) {
          log("Animation reverse");
          _currentColor = cubit.state.onboards[cubit.state.currentIndex].color;
        }
        if (status == AnimationStatus.completed) {
          log("Animation completed");
          cubit.nextPage();
          _controller.reverse(from: 1);
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = context.read<OnboardingCubit>();
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is CurrentIndexChanged) {
          _currentColor = state.onboards[state.currentIndex].color;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: state.onboards[state.currentIndex].color,
          body: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: 16,
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  width: 56 * _scaleAnimation.value,
                  height: 56 * _scaleAnimation.value,
                  duration: const Duration(milliseconds: 800),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _currentColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              PageView.builder(
                controller: onboardingCubit.pageController,
                onPageChanged: onboardingCubit.onPageChanged,
                allowImplicitScrolling: true,
                itemBuilder: (context, index) {
                  final onboard = state.onboards[index];
                  return OnboardinPageWidget(onboard);
                },
                itemCount: state.onboards.length,
              ),
              Positioned(
                bottom: 16,
                child: InkWell(
                  onTap: () {
                    if (_controller.isAnimating) return;
                    if (state.currentIndex == state.onboards.length - 1) return;
                    _controller.forward();
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: state.onboards[(state.currentIndex + 1) % 3].color,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
