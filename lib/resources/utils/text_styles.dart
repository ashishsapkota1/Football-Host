import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';

class TextStyles {
  static const TextStyle appBarText = TextStyle(
    color: AppColor.backGroundColor,
    fontSize: 18,
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

  static const TextStyle teamCardText2 =
  TextStyle(color: Colors.black54, fontSize: 14);

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

  static const TextStyle matchStyle = TextStyle(

    fontSize: 24,
    fontWeight: FontWeight.w600
  );

  static const TextStyle scoreStyle = TextStyle(

      fontSize: 28,
      fontWeight: FontWeight.w700
  );

  static const TextStyle positionStyle = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.bold
  );

  static const TextStyle draggedStyle = TextStyle(
    color: AppColor.positionNameColor,
    fontSize: 14
  );

  static const TextStyle lineUpTeamNameStyle = TextStyle(
    color: Colors.white,
    fontSize: 20
  );

  static const TextStyle timerStyle = TextStyle(
    color: Colors.black,
    fontSize: 24
  );

  static const TextStyle timeLineStyle = TextStyle(
    color: AppColor.appBarColor,
    fontSize: 14,
    fontWeight: FontWeight.bold
  );

}
