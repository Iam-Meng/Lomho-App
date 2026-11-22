import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: WelcomeScreen()));
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
        
      ),
      body: Padding(padding: EdgeInsets.all(20)),
      );
  }
}
