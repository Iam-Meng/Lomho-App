import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/step_indicator.dart';

/// Step 2 of onboarding: the user enters their first and last name.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // Creates the State object that holds this screen's data (the name fields).
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Hold the text typed into the First name / Last name fields.
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  // Typed names with spaces removed from both ends.
  String get _firstName => _firstNameController.text.trim();
  String get _lastName => _lastNameController.text.trim();

  // Continue is only enabled when both names are filled in.
  bool get _canContinue => _firstName.isNotEmpty && _lastName.isNotEmpty;

  // Scoped to this screen so the snackbar doesn't follow you to other routes.
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  // Runs once when the screen opens. super.initState() must come first.
  // Listens to both fields so the "Hi, <name>" preview updates while typing.
  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_refresh);
    _lastNameController.addListener(_refresh);
  }

  // Redraws the screen (preview card + Continue button) after each keystroke.
  void _refresh() => setState(() {});

  // Free the text controllers (and their listeners) when this screen is closed,
  // so they don't stay in memory. super.dispose() must come last.
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  // Called when Continue is tapped. Closes any old snackbar, then shows the
  // welcome message.
  void _onContinue() {
    // save the name and go to the next screen.
    _messengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Welcome to LOMHO, $_firstName!')));
  }

  // Wraps the screen in its own ScaffoldMessenger so snackbars stay on Login.
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _messengerKey,
      child: _buildScaffold(context),
    );
  }

  // The actual page layout: top bar, header, name fields, preview, Continue.
  // Scrollable so the keyboard doesn't cover the fields on small phones.
  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _TopBar(currentStep: 2, totalSteps: 2),
                    const SizedBox(height: 24),
                    const _Header(
                      stepLabel: 'STEP 2 OF 2 · YOUR NAME',
                      title: 'What should we call you?',
                      subtitle: 'LOMHO greets you by your first name.',
                    ),
                    const SizedBox(height: 20),
                    _NameField(
                      label: 'First name',
                      hint: 'e.g. Ronan',
                      controller: _firstNameController,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    _NameField(
                      label: 'Last name',
                      hint: 'e.g. Ogor',
                      controller: _lastNameController,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'PREVIEW',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: AppColors.subText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _GreetingPreview(
                      firstName: _firstName,
                      lastName: _lastName,
                    ),
                    const Spacer(),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      label: 'Continue',
                      onPressed: _canContinue ? _onContinue : null,
                      color: AppColors.text,
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'You can change it later in Settings.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.subText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Back button on the left, step dashes centred.
class _TopBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  const _TopBar({required this.currentStep, required this.totalSteps});

  // Back button closes this page and returns to Welcome.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.border),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.of(context).maybePop(),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.chevron_left, color: AppColors.text),
                ),
              ),
            ),
          ),
          StepIndicator(currentStep: currentStep, totalSteps: totalSteps),
        ],
      ),
    );
  }
}

/// Small blue step label, big title, and grey subtitle at the top of the page.
class _Header extends StatelessWidget {
  final String stepLabel;
  final String title;
  final String subtitle;

  const _Header({
    required this.stepLabel,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepLabel,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1.15,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 14, color: AppColors.subText),
        ),
      ],
    );
  }
}

/// A label with a rounded text box under it. Used for First name and Last name.
/// The text goes into [controller]; [textInputAction] sets the keyboard's
/// bottom-right key (next field or done).
class _NameField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool autofocus;
  final TextInputAction textInputAction;

  const _NameField({
    required this.label,
    required this.hint,
    required this.controller,
    this.autofocus = false,
    required this.textInputAction,
  });

  // Grey border normally, blue border while the field is selected.
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.border),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          autofocus: autofocus,
          textCapitalization: TextCapitalization.words,
          textInputAction: textInputAction,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.subText,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Live preview of how the home screen will greet the user.
class _GreetingPreview extends StatelessWidget {
  final String firstName;
  final String lastName;

  const _GreetingPreview({required this.firstName, required this.lastName});

  static const _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  // First letter of each name, e.g. "Ronan Ogor" -> "RO". Shows "?" if empty.
  String get _initials {
    final first = firstName.isNotEmpty ? firstName[0] : '';
    final last = lastName.isNotEmpty ? lastName[0] : '';
    final initials = (first + last).toUpperCase();
    return initials.isEmpty ? '?' : initials;
  }

  // Formats a date like "Monday, 23 November".
  String _formatDate(DateTime d) =>
      '${_weekdays[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]}';

  // Card with the initials box on the left, today's date and "Hi, <name>".
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _initials,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDate(DateTime.now()),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.subText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  firstName.isEmpty ? 'Hi there' : 'Hi, $firstName',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
