import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/responsive.dart';
import 'package:football_host/view_model/player_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/model/player_model.dart';
import '../../../resources/utils/text_styles.dart';

class PlayingXiTeam1 extends StatefulWidget {
  final int? teamId;
  const PlayingXiTeam1({super.key, required this.teamId});

  @override
  State<PlayingXiTeam1> createState() => _PlayingXiTeam1State();
}

class _PlayingXiTeam1State extends State<PlayingXiTeam1> {
  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    playerViewModel.getPlayers(widget.teamId!);
    final playerList = playerViewModel.playerList;
    return SizedBox(
      height: Responsive.screenHeight(context) * 0.15,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: playerList.length,
            itemBuilder: (context, index){
            return LongPressDraggable<Player>(
              childWhenDragging: Container(),
              feedback:Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Column(
                      children: [
                        Text(playerList[index].jerseyNo!.toString()),
                      ],
                    ),
                  ),
                  Text(playerList[index].playerName!, style: TextStyles.cardText,)
                ],
              ),
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
                  Text(playerList[index].playerName!)
                ],
              ),
            );

            }),
      ),
    );
  }
}
