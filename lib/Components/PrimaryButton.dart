import 'package:e_book/Config/Colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String btnName;
  final VoidCallback ontap;
  final Color? color; // Tambahkan parameter color

  const PrimaryButton({
    super.key,
    required this.btnName,
    required this.ontap,
    this.color, // Tambahkan parameter color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 55,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.primary, // Gunakan parameter color
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: backgroudColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset("Assets/Icons/google.png"),
            ),
            const SizedBox(width: 10),
            Text(
              btnName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
