import 'package:flutter/material.dart';
import 'package:kings_store/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: AppColors.primaryColor,
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
