import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';

class TextStyles {
  static const TextStyle appBarText = TextStyle(
    color: AppColor.backGroundColor,
    fontSize: 24,
    fontFamily: 'Poppins',
  );

  static const TextStyle buttonText =
      TextStyle(color: AppColor.backGroundColor, fontSize: 14);

  static const TextStyle cardText = TextStyle(
    color: AppColor.appBarColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle teamCardText =
      TextStyle(color: AppColor.appBarColor, fontSize: 18);
  static const TextStyle scheduleText = TextStyle(
      color: AppColor.appBarColor, fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle roundNameText = TextStyle(
    color: AppColor.textGreen,
    fontSize: 16,
  );
  static const TextStyle cancelText = TextStyle(
      color: Colors.red, fontSize: 16, decoration: TextDecoration.underline);
  static const TextStyle confirmText = TextStyle(
      fontSize: 16,
      color: AppColor.appBarColor,
      decoration: TextDecoration.underline);

  static const TextStyle tabBarStyle = TextStyle(
    color: AppColor.backGroundColor,
  );
}
