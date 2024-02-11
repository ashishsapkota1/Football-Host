import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/routes/routes_name.dart';
import 'package:football_host/view_model/teamViewModel/teamName_view_model.dart';
import 'package:football_host/view_model/teamViewModel/team_view_model.dart';
import 'package:football_host/view_model/tournamentName_view_model.dart';
import 'package:provider/provider.dart';
import '../../resources/app_colors.dart';
import '../../resources/utils/responsive.dart';
import '../../resources/utils/text_styles.dart';

class TournamentTeams extends StatefulWidget {
  const TournamentTeams({super.key});

  @override
  State<TournamentTeams> createState() => _TournamentTeamsState();
}

class _TournamentTeamsState extends State<TournamentTeams> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    TournamentNameViewModel tournamentNameViewModel =
    Provider.of<TournamentNameViewModel>(context);
    final tournamentId = tournamentNameViewModel.selectedTournamentId;
    Provider.of<TeamViewModel>(context).getTournamentTeams(tournamentId!);
  }

  @override
  Widget build(BuildContext context) {
    TeamViewModel teamViewModel = Provider.of<TeamViewModel>(context,listen: true);
    final teamList = teamViewModel.tournamentTeams;
    return Column(
      children: [
        Expanded(
          child:teamList.isEmpty? const Center(child: Text('Please add Teams first',style: TextStyles.cardText)) : ListView.builder(
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
                        final teamNameModel =
                        Provider.of<TeamNameViewModel>(context,
                            listen: false);
                        final selectedTeamName =
                            teamList[index].teamName;
                        teamNameModel
                            .setSelectedTeam(selectedTeamName!);
                        final selectedTeamId = teamList[index].id;
                        teamNameModel
                            .setSelectedTeamId(selectedTeamId!);
                        Navigator.pushNamed(
                            context, RoutesName.teamPlayers,
                            );
                        print(selectedTeamId);
                      },
                      child: Card(
                        elevation: 2,
                        color: AppColor.cardGrey,
                        child: ListTile(
                          title: Text(
                            teamList[index].teamName!,
                            style: TextStyles.teamCardText,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            })

        ),
      ],
    );
  }
}
