import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';

class TextStyles {
  static  const TextStyle appBarText = TextStyle(
    color: AppColor.backGroundColor,
    fontSize: 24,
    fontFamily: 'Poppins'
  );

  static const TextStyle buttonText = TextStyle(
    color: AppColor.backGroundColor,
    fontSize: 14
  );

  static const TextStyle cardText = TextStyle(
    color: AppColor.appBarColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle teamCardText = TextStyle(
    color: AppColor.appBarColor,
    fontSize: 18
  );
}