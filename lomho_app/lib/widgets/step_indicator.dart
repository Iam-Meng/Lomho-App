import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Row of dashes showing onboarding progress.
/// Steps up to and including [currentStep] are filled. All dashes are the same size.
class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (index) {
        final isFilled = index < currentStep;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 20,
          height: 6,
          decoration: BoxDecoration(
            color: isFilled ? AppColors.primary : AppColors.border,
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}
