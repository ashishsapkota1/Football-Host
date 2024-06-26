import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/responsive.dart';
import 'package:football_host/view_model/player_view_model.dart';
import 'package:provider/provider.dart';
import '../../../data/model/player_model.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/utils/text_styles.dart';

class PlayingXiTeam2 extends StatefulWidget {
  final int? teamId;

  const PlayingXiTeam2({super.key, required this.teamId});

  @override
  State<PlayingXiTeam2> createState() => _PlayingXiTeam2State();
}

class _PlayingXiTeam2State extends State<PlayingXiTeam2> {
  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    playerViewModel.get2Players(widget.teamId!);

    final playerList = playerViewModel.playerList2;
    return playerList.isEmpty
        ? const Text(
            'please add players first to drag and drop',
            style: TextStyles.confirmText,
          )
        : SizedBox(
            height: Responsive.screenHeight(context) * 0.10,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: playerList.length,
                  itemBuilder: (context, index) {
                    return LongPressDraggable<Player>(
                      data: playerList[index],
                      childWhenDragging: Container(),
                      onDragCompleted: () {
                        setState(() {
                          playerList.removeAt(index);
                        });
                      },
                      feedback: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColor.lineUpColor,
                            child: Column(
                              children: [
                                Center(
                                    child: Text(playerList[index]
                                        .position!
                                        .substring(0, 3))),
                              ],
                            ),
                          ),
                          Text(
                            playerList[index]
                                .playerName!
                                .split(RegExp('\\s+'))[0],
                            style: TextStyles.draggedStyle,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Column(
                                children: [
                                  Text(playerList[index].jerseyNo!.toString()),
                                ],
                              ),
                            ),
                            Text(playerList[index]
                                .playerName!
                                .split(RegExp('\\s+'))[0])
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
  }
}
