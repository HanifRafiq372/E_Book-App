import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
    children: [
        Container(
          height: 500,
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                "Assets/Images/book.png",
                width: 380,
                ),
                SizedBox(height: 60),
                Text("E - Book Store",style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).colorScheme.background,
                ),),],
              )
            ]),
          )
        ],
      ));
  }
}