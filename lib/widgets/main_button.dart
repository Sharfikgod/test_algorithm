import 'package:flutter/material.dart';
import 'package:test_work/consts/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    required this.onPressed,
    required this.title,
    super.key,
  });

  final Future<void> Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                width: 2,
                color: Colors.blueAccent,
              )),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
