import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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


    Future<void> deleteTeam(int teamId) async {
      Navigator.pop(context);
      await teamViewModel.deleteTeam(teamId);
    }

    void cancel() {
      Navigator.pop(context);
    }

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
                        color: AppColor.appBarColor,
                        child: Slidable(
                          startActionPane: ActionPane(
                            extentRatio: 0.5,
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext context) {
                                  AlertDialog alert = AlertDialog(
                                    title: const Text(
                                      'Delete Team',
                                      style: TextStyles.scheduleText,
                                    ),
                                    actions: [
                                      Row(
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                await deleteTeam(
                                                    teamList[index]
                                                        .id!);
                                              },
                                              child: const Text('Confirm',
                                                  style: TextStyles
                                                      .confirmText)),
                                          TextButton(
                                              onPressed: () {
                                                cancel();
                                              },
                                              child: const Text('Cancel',
                                                  style: TextStyles
                                                      .cancelText))
                                        ],
                                      )
                                    ],
                                  );
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return alert;
                                      });
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                label: 'Delete',
                              )
                            ],
                          ),
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
