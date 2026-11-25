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
  int _currentStep = 1;
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _buildInitials() {
    final name = _nameController.text.trim();
    final nameInitial = name.isNotEmpty ? name[0].toUpperCase() : '';
    return nameInitial;
  }

  String _buildGreeting() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return 'Hi there';
    return 'Hi, $name';
  }

  Widget _buildNameStepContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Name',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _nameController,
          textInputAction: TextInputAction.next,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Enter your name here',
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE4E6EE)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE4E6EE)),
            ),
          ),
        ),
        const SizedBox(height: 36),
        const Text(
          'PREVIEW',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE4E6EE)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF4C5FD5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _buildInitials(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to Lomho',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    _buildGreeting(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

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
          child: _currentStep == 1
              ? Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/welcome-screen-riel-usd.webp',
                        ),
                      ),
                    ),
                    NavPanel(
                      title: 'Dollars and Riels,\nin One Pocket.',
                      description: 'Every account holds both \$ and ៛. Pay in whichever you have, and Lomho adds it all up.',
                      currentStep: 1,
                      totalSteps: 2,
                      stepLabel: 'Meet Lomho',
                      onNext: () {
                        setState(() {
                          _currentStep = 2;
                        });
                      },
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: NavPanel(
                    title: 'What should we call you?',
                    description: 'Lomho greets you by your name.',
                    currentStep: 2,
                    totalSteps: 2,
                    stepLabel: 'YOUR NAME',
                    buttonText: 'Continue',
                    onBack: () {
                      setState(() {
                        _currentStep = 1;
                      });
                    },
                    bodyContent: _buildNameStepContent(),
                    onNext: () {
                      // Go to home dashboard, TBC...
                    },
                    footerText: 'You can change it later in Settings.',
                  ),
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
  final VoidCallback? onBack;
  final Widget? bodyContent;
  final String? footerText;

  const NavPanel({
    super.key,
    required this.title,
    required this.description,
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabel,
    this.buttonText = 'Next',
    required this.onNext,
    this.onBack,
    this.bodyContent,
    this.footerText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onBack != null) ...[
          InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE4E6EE)),
              ),
              child: const Icon(Icons.chevron_left, size: 22),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Row(
          children: [
            ...List.generate(totalSteps, (index) {
              final isActive = index <= currentStep - 1;
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
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(fontSize: 15, color: Colors.grey, height: 1.4),
        ),
        if (bodyContent != null) ...[const SizedBox(height: 20), bodyContent!],
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
        if (footerText != null) ...[
          const SizedBox(height: 12),
          Center(
            child: Text(
              footerText!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ],
    );
  }
}
