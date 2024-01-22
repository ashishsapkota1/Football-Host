import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/utils/text_styles.dart';

class TeamPlayers extends StatefulWidget {
  final String? teamName;
  const TeamPlayers({super.key, this.teamName});

  @override
  State<TeamPlayers> createState() => _TeamPlayersState();
}

class _TeamPlayersState extends State<TeamPlayers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: const Text(
          'Team',
          style: TextStyles.appBarText,
        ),
        centerTitle: true,
      ),

    );
  }
}
