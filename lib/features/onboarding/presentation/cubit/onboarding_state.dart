part of 'onboarding_cubit.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState({
    required this.onboards,
    required this.currentIndex,
  });

  final List<Onboard> onboards;
  final int currentIndex;

  @override
  List<Object?> get props => [onboards, currentIndex];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial({
    super.onboards = const [],
    super.currentIndex = 0,
  });
}

class CurrentIndexChanged extends OnboardingState {
  const CurrentIndexChanged({
    required super.onboards,
    required super.currentIndex,
  });
}
