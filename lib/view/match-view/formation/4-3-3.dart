import 'package:flutter/material.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/utils/responsive.dart';

class FormationNo1 extends StatelessWidget {
  final int quarterTurn;
   const FormationNo1({super.key, required this.quarterTurn});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
          height: Responsive.screenHeight(context) * 0.4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RotatedBox(
              quarterTurns: quarterTurn,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.lineUpColor,
                        borderRadius: BorderRadius.circular(8),
                        border:
                        Border.all(color: AppColor.backGroundColor, width: 2)),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: Container(
                                width: Responsive.screenWidth(context) * 0.25,
                                height: Responsive.screenHeight(context) * 0.08,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                      color: AppColor.backGroundColor,
                                    )),
                                child: const Center(child: CircleAvatar()),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: Responsive.screenWidth(context) * 0.6,
                                height: Responsive.screenHeight(context) * 0.16,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                      color: AppColor.backGroundColor,
                                    )),
                              ),
                            ),
                            Positioned(
                                left: Responsive.screenWidth(context)*0.05,
                                top: Responsive.screenHeight(context)*0.10,
                                child: CircleAvatar()),
                            Positioned(
                                left: Responsive.screenWidth(context)*0.3,
                                top: Responsive.screenHeight(context)*0.10,
                                child: CircleAvatar()),
                            Positioned(
                                left: Responsive.screenWidth(context)*0.55,
                                top: Responsive.screenHeight(context)*0.10,
                                child: CircleAvatar()),
                            Positioned(
                                left: Responsive.screenWidth(context)*0.8,
                                top: Responsive.screenHeight(context)*0.10,
                                child: CircleAvatar()),

                          ],
                        ),
                        Container(
                            width: 30,
                            height: 10,
                            decoration: BoxDecoration(
                                color: AppColor.lineUpColor,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(90.0),
                                  bottomRight: Radius.circular(90.0),
                                ),
                                border: Border.all(color: AppColor.backGroundColor))),
                      ],
                    ),
                  ),
                  Positioned(
                      left: Responsive.screenWidth(context)*0.09,
                      top: Responsive.screenHeight(context)*0.20,
                      child: CircleAvatar()),
                  Positioned(
                      left: Responsive.screenWidth(context)*0.45,
                      top: Responsive.screenHeight(context)*0.20,
                      child: CircleAvatar()),
                  Positioned(
                      left: Responsive.screenWidth(context)*0.8,
                      top: Responsive.screenHeight(context)*0.20,
                      child: CircleAvatar()),
                  Positioned(
                      left: Responsive.screenWidth(context)*0.09,
                      top: Responsive.screenHeight(context)*0.30,
                      child: CircleAvatar()),
                  Positioned(
                      left: Responsive.screenWidth(context)*0.45,
                      top: Responsive.screenHeight(context)*0.30,
                      child: CircleAvatar()),
                  Positioned(
                      left: Responsive.screenWidth(context)*0.8,
                      top: Responsive.screenHeight(context)*0.30,
                      child: CircleAvatar()),
                ],
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: Responsive.screenHeight(context) * 0.4,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: RotatedBox(
        //       quarterTurns: 2,
        //       child: Stack(
        //         children: [
        //           Container(
        //             decoration: BoxDecoration(
        //                 color: AppColor.lineUpColor,
        //                 borderRadius: BorderRadius.circular(8),
        //                 border:
        //                 Border.all(color: AppColor.backGroundColor, width: 2)),
        //             child: Column(
        //               children: [
        //                 Stack(
        //                   children: [
        //                     Center(
        //                       child: Container(
        //                         width: Responsive.screenWidth(context) * 0.25,
        //                         height: Responsive.screenHeight(context) * 0.08,
        //                         decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(2),
        //                             border: Border.all(
        //                               color: AppColor.backGroundColor,
        //                             )),
        //                         child: const Center(child: CircleAvatar()),
        //                       ),
        //                     ),
        //                     Center(
        //                       child: Container(
        //                         width: Responsive.screenWidth(context) * 0.6,
        //                         height: Responsive.screenHeight(context) * 0.16,
        //                         decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(2),
        //                             border: Border.all(
        //                               color: AppColor.backGroundColor,
        //                             )),
        //                       ),
        //                     ),
        //                     Positioned(
        //                         left: Responsive.screenWidth(context)*0.05,
        //                         top: Responsive.screenHeight(context)*0.10,
        //                         child: CircleAvatar()),
        //                     Positioned(
        //                         left: Responsive.screenWidth(context)*0.3,
        //                         top: Responsive.screenHeight(context)*0.10,
        //                         child: CircleAvatar()),
        //                     Positioned(
        //                         left: Responsive.screenWidth(context)*0.55,
        //                         top: Responsive.screenHeight(context)*0.10,
        //                         child: CircleAvatar()),
        //                     Positioned(
        //                         left: Responsive.screenWidth(context)*0.8,
        //                         top: Responsive.screenHeight(context)*0.10,
        //                         child: CircleAvatar()),
        //
        //                   ],
        //                 ),
        //                 Container(
        //                     width: 30,
        //                     height: 10,
        //                     decoration: BoxDecoration(
        //                         color: AppColor.lineUpColor,
        //                         borderRadius: const BorderRadius.only(
        //                           bottomLeft: Radius.circular(90.0),
        //                           bottomRight: Radius.circular(90.0),
        //                         ),
        //                         border: Border.all(color: AppColor.backGroundColor))),
        //               ],
        //             ),
        //           ),
        //           Positioned(
        //               left: Responsive.screenWidth(context)*0.09,
        //               top: Responsive.screenHeight(context)*0.20,
        //               child: CircleAvatar()),
        //           Positioned(
        //               left: Responsive.screenWidth(context)*0.45,
        //               top: Responsive.screenHeight(context)*0.20,
        //               child: CircleAvatar()),
        //           Positioned(
        //               left: Responsive.screenWidth(context)*0.8,
        //               top: Responsive.screenHeight(context)*0.20,
        //               child: CircleAvatar()),
        //           Positioned(
        //               left: Responsive.screenWidth(context)*0.09,
        //               top: Responsive.screenHeight(context)*0.30,
        //               child: CircleAvatar()),
        //           Positioned(
        //               left: Responsive.screenWidth(context)*0.45,
        //               top: Responsive.screenHeight(context)*0.30,
        //               child: CircleAvatar()),
        //           Positioned(
        //               left: Responsive.screenWidth(context)*0.8,
        //               top: Responsive.screenHeight(context)*0.30,
        //               child: CircleAvatar()),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
