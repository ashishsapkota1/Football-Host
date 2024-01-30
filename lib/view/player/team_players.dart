import 'package:flutter/material.dart';
import 'package:football_host/resources/components/add_player_form.dart';
import 'package:football_host/view_model/player_view_model.dart';
import 'package:football_host/view_model/teamViewModel/teamName_view_model.dart';
import 'package:provider/provider.dart';

import '../../resources/app_colors.dart';
import '../../resources/utils/responsive.dart';
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

    final getTeamName = Provider.of<TeamNameViewModel>(context, listen: false);
    final teamId = getTeamName.selectedTeamId;
    final teamName = getTeamName.selectedTeam;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title:  Text(
          'Team: $teamName',
          style: TextStyles.appBarText,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<PlayerViewModel>(
              builder: (context, viewModel, _) {
                final playerList = viewModel.getPlayerList(teamId!);
                return ListView.builder(
                    itemCount: playerList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: Responsive.screenWidth(context) * 0.02,
                              right: Responsive.screenWidth(context) * 0.02,
                              top: Responsive.screenHeight(context) * 0.01,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // final teamNameModel = Provider.of<TeamNameViewModel>(context, listen: false);
                                // final selectedTeamName = [index].teamName;
                                // teamNameModel.setSelectedTeam(selectedTeamName!);
                                // final selectedTeamId = teamList[index].id;
                                // teamNameModel.setSelectedTeamId(selectedTeamId!);
                                // Navigator.pushNamed(context, RoutesName.teamPlayers,arguments: selectedTeamName);
                                // print(teamList[index].tournamentId);
                                print(playerList[index].playerName);
                                print(playerList[index].id);
                              },
                              child: Card(
                                elevation: 2,
                                color: AppColor.cardGrey,
                                child: ListTile(
                                  title: Text('Name :${playerList[index].playerName!}', style: TextStyles.teamCardText,),
                                  subtitle: Text('Position: ${playerList[index].position!}',style: TextStyles.teamCardText,),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const AddPlayerForm(),

    );
  }
}
