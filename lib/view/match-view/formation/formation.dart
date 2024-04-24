import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/resources/utils/text_styles.dart';
import '../../../data/model/player_model.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/utils/responsive.dart';
import '../../../resources/utils/utils.dart';

class FormationNo1 extends StatefulWidget {
  final int quarterTurn;
  final int? teamId;
  final String? teamName;
  final int? upperContainerQTurn;
  final int avatarQuarterTurn;
  final List<Offset> positions;

  const FormationNo1(
      {super.key,
      this.teamId,
      required this.teamName,
      required this.quarterTurn,
      required this.positions,
      required this.avatarQuarterTurn, this.upperContainerQTurn});

  @override
  State<FormationNo1> createState() => _FormationNo1State();
}

class _FormationNo1State extends State<FormationNo1> {
  List<Map<String, dynamic>> droppedPlayers = [];
  bool _isDropped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Responsive.screenHeight(context) * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RotatedBox(
              quarterTurns: widget.quarterTurn,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.lineUpColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColor.backGroundColor, width: 2)),
                    child: Column(
                      children: [
                        RotatedBox(
                          quarterTurns: widget.upperContainerQTurn!,
                          child: Container(
                            height: Responsive.screenHeight(context) * 0.06,
                            decoration: BoxDecoration(
                              color: AppColor.upperLineUpContainerColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                verticalSpacing(space: 20),
                                Text(widget.teamName!, style: TextStyles.lineUpTeamNameStyle,)],
                            ),
                          ),
                        ),
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
                                border: Border.all(
                                    color: AppColor.backGroundColor))),
                      ],
                    ),
                  ),
                  Stack(
                    children: _buildAvatar(context),
                  ),
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

    for (var i = 0; i < widget.positions.length; i++) {
      final position = widget.positions[i];
      final left = Responsive.screenWidth(context) * position.dx;
      final top = Responsive.screenHeight(context) * position.dy;

      avatar.add(
        Positioned(
          left: left,
          top: top,
          child: DragTarget<Player>(
            onAccept: (data) {
              if (data.teamId == widget.teamId) {
                bool isDroppedAlready = droppedPlayers
                    .any((element) => element['player'].id == data.id);
                if (!isDroppedAlready) {
                  setState(() {
                    droppedPlayers
                        .add({'player': data, 'position': widget.positions[i]});
                    _isDropped = true;
                  });
                } else {
                  Utils.flushBarErrorMessage('Player already dropped', context);
                }
              } else {
                Utils.flushBarErrorMessage(
                    'Can\'t dropped to another team', context);
              }
            },
            builder: (context, candidateData, rejectedData) {
              var droppedPlayer = droppedPlayers.firstWhere(
                (element) => element['position'] == widget.positions[i],
                orElse: () => {},
              );
              if (_isDropped == true && droppedPlayer.isNotEmpty) {
                return RotatedBox(
                  quarterTurns: widget.avatarQuarterTurn,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.appBarColor,
                        radius: 20,
                        child:
                            Text(droppedPlayer['player'].jerseyNo!.toString()),
                      ),
                      Text(
                        droppedPlayer['player']
                            .playerName!
                            .split(RegExp('\\s+'))[0],
                        style: TextStyles.positionStyle,
                      )
                    ],
                  ),
                );
              } else {
                return const CircleAvatar(
                  radius: 20,
                );
              }
            },
          ),
        ),
      );
    }

    return avatar;
  }
}
