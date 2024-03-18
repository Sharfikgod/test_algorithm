import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_work/consts/app_colors.dart';

class ScaffoldWithAppBar extends StatelessWidget {
  const ScaffoldWithAppBar({
    required this.body,
    required this.title,
    super.key,
  });

  final Widget body;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppColors.secondary),
        elevation: 20,
        backgroundColor: AppColors.primary,
        title: Text(title, style: const TextStyle(color: Colors.white)),
      ),
      body: body,
    );
  }
}
