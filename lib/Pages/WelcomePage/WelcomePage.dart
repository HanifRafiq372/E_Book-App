import 'package:e_book/Controller/AuthController.dart'; // Import AuthController
import 'package:e_book/Components/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1C2638),
                    Color(0xFF0F6DFB),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "Assets/Images/logo.png",
                    width: 150, // Sesuaikan lebar
                    height: 150, // Sesuaikan tinggi
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "EduPrime App",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "E-Book Learning",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Disclaimer",
                    style: Theme.of(context).textTheme.subtitle2, // Menggunakan subtitle2
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2, // Menggunakan bodyText2
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    btnName: "LOGIN",
                    onTap: () {
                      authController.loginWithEmail();
                    },
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    btnName: "SIGNUP",
                    onTap: () {
                      authController.signupWithEmailPassword(); // Menggunakan signupWithEmailPassword
                    },
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}