import 'package:animate_onboarding/features/onboarding/domain/entities/onboard.dart';
import 'package:flutter/material.dart';

class OnboardinPageWidget extends StatelessWidget {
  const OnboardinPageWidget(this.onboard, {super.key});

  final Onboard onboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(onboard.title),
        Text(onboard.description),
        Image.network(onboard.imageUrl),
      ],
    );
  }
}
