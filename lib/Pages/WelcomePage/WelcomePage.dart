import 'package:flutter/material.dart';

class WelcomePage extends StatelessElement {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [Text("Welcome Page")],
        ),
      ),
    );
  }
}