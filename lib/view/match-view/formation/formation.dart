import 'package:flutter/material.dart';

import '../../../data/model/player_model.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/utils/responsive.dart';
import '../../../resources/utils/utils.dart';


class FormationNo1 extends StatelessWidget {
  final int quarterTurn;
  final List<Offset> position;
  const FormationNo1({super.key, required this.quarterTurn, required this.position});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  DragTarget<Player>(
                    onAccept: (data) => data,


                    builder: (context, can, rej){

                    return Stack(
                      children: _buildAvatar(context),
                    );}
                  )

                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
  List<Widget> _buildAvatar(BuildContext context) {
    List<Widget> avatar = [];

    for (var i = 0; i < position.length; i++) {
      final positions = position[i];
      final left = Responsive.screenWidth(context) * positions.dx;
      final top = Responsive.screenHeight(context) * positions.dy;

      avatar.add(
        Positioned(
          left: left,
          top: top,
          child: const CircleAvatar(
            radius: 20,

          ),
        ),
      );
    }

    return avatar;
  }
}




