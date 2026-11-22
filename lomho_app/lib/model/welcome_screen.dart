import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: WelcomeScreen()),
  );
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            const Text("LOMHO", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {}, // To Do
            child: const Text("Skip"),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset('assets/welcome-screen-riel-usd.webp',),
                ),
              ),
              NavPanel(
                title: 'Dollars and Riels,\nin One Pocket.',
                description: 'Every account holds both \$ and ៛. Pay in whichever you have, and Lomho adds it all up.',
                currentStep: 1,
                totalSteps: 2,
                stepLabel: 'Meet Lomho',
                onNext: () {},
              ),
              // To Do Step 2: Maybe using navigator push
            ],
          ),
        ),
      ),
    );
  }
}

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
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(fontSize: 15, color: Colors.grey, height: 1.4),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            ...List.generate(totalSteps, (index) {
              final isActive = index == currentStep - 1;
              return Container(
                margin: const EdgeInsets.only(right: 6),
                width: isActive ? 22 : 18,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF4C5FD5)
                      : const Color(0xFFE4E6EE),
                  borderRadius: BorderRadius.circular(999),
                ),
              );
            }),
            const SizedBox(width: 8),
            Text(
              'Step $currentStep of $totalSteps · $stepLabel',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton(
            onPressed: onNext,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF14181F),
              shape: const StadiumBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(buttonText),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
