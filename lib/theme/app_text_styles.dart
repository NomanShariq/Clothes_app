import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.3,
    color: AppColors.labelText,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    color: AppColors.bodyText,
  );

  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.labelText,
  );

  static const TextStyle hint = TextStyle(
    fontSize: 14,
    color: AppColors.hintText,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.white,
  );

  static TextStyle linkBold = const TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle linkSmall = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.w600,
    fontSize: 13,
  );
}
