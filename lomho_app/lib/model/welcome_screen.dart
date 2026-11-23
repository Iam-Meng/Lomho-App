import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/step_indicator.dart';
import 'login_screen.dart';

/// Step 1 of onboarding: the first screen the app opens on.
/// Shows the logo, the Riel/USD picture, and a Next button that opens Login.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomeScreen> {
  // Page layout: app bar with logo, big picture in the middle, NavPanel at the
  // bottom. Next pushes LoginScreen as a new page (back arrow returns here).
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.text,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/Lomho_Logo.webp',
                height: 32,
                width: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "LOMHO",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset('assets/welcome-screen-riel-usd.webp'),
                ),
              ),
              NavPanel(
                title: 'Dollars and Riels,\nin One Pocket.',
                description: 'Every account holds both \$ and ៛. Pay in whichever you have, and Lomho adds it all up.',
                currentStep: 1,
                totalSteps: 2,
                stepLabel: 'Meet Lomho',
                onNext: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom part of Welcome: title, description, step dashes with a
/// "Step X of Y" label, and the Next button. [onNext] runs when it's tapped.
class NavPanel extends StatelessWidget {
  final String title;
  final String description;
  final int currentStep;
  final int totalSteps;
  final String stepLabel;
  final String buttonText;
  final VoidCallback onNext;

  const NavPanel({
    super.key,
    required this.title,
    required this.description,
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabel,
    this.buttonText = 'Next',
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.subText,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            StepIndicator(currentStep: currentStep, totalSteps: totalSteps),
            const SizedBox(width: 8),
            Text(
              'Step $currentStep of $totalSteps · $stepLabel',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.subText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        PrimaryButton(label: buttonText, onPressed: onNext),
      ],
    );
  }
}
