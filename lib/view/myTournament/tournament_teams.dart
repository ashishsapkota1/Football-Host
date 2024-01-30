import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/routes/routes_name.dart';
import 'package:football_host/view_model/teamViewModel/teamName_view_model.dart';
import 'package:football_host/view_model/teamViewModel/team_view_model.dart';
import 'package:football_host/view_model/tournamentName_view_model.dart';
import 'package:provider/provider.dart';

import '../../resources/app_colors.dart';
import '../../resources/utils/responsive.dart';
import '../../resources/utils/text_styles.dart';

class TournamentTeams extends StatelessWidget {
  const TournamentTeams({super.key});

  @override
  Widget build(BuildContext context) {

    final getTournamentId = Provider.of<TournamentNameViewModel>(context);
    final tournamentId = getTournamentId.selectedTournamentId;
    return Column(
      children: [
        Expanded(
          child: Consumer<TeamViewModel>(
            builder: (context, viewModel, _) {
              final teamList = viewModel.getTournamentTeams(tournamentId!);
              print(teamList);

              return ListView.builder(
                  itemCount: teamList.length,
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
                              final teamNameModel = Provider.of<TeamNameViewModel>(context, listen: false);
                              final selectedTeamName = teamList[index].teamName;
                              teamNameModel.setSelectedTeam(selectedTeamName!);
                              final selectedTeamId = teamList[index].id;
                              teamNameModel.setSelectedTeamId(selectedTeamId!);
                              Navigator.pushNamed(context, RoutesName.teamPlayers,arguments: selectedTeamName);
                              print(selectedTeamId);
                            },
                            child: Card(
                              elevation: 2,
                              color: AppColor.cardGrey,
                              child: ListTile(
                                title: Text(teamList[index].teamName!, style: TextStyles.teamCardText,),
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
    );
  }
}
