import 'package:flutter/material.dart';
import 'package:just_todo/constants/app_colors.dart';

class CustomButtonWidget {
  static draw(
    dynamic onPressed,
    String title,
    double size, {
    Color? color,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(size, 24),
        primary: color ?? AppColors.primaryColor,
      ),
      onPressed: () => {onPressed()},
      child: Text(title),
    );
  }
}
