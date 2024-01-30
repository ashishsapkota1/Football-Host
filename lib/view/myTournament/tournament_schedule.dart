import 'package:flutter/material.dart';
import 'package:football_host/data/model/match/match_schedule_model.dart';
import 'package:football_host/view_model/matchViewModel/schedule_view_model.dart';
import 'package:football_host/view_model/teamViewModel/teamName_view_model.dart';
import 'package:football_host/view_model/teamViewModel/team_view_model.dart';
import 'package:provider/provider.dart';

import '../../data/model/team_model.dart';
import '../../resources/app_colors.dart';
import '../../resources/utils/responsive.dart';
import '../../resources/utils/text_styles.dart';
import '../../view_model/tournamentName_view_model.dart';

class TournamentSchedule extends StatefulWidget {
  const TournamentSchedule({super.key});

  @override
  State<TournamentSchedule> createState() => _TournamentScheduleState();
}

class _TournamentScheduleState extends State<TournamentSchedule> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getTournamentId = Provider.of<TournamentNameViewModel>(context);
    final tournamentId = getTournamentId.selectedTournamentId;
    final teamViewModel = Provider.of<TeamViewModel>(context, listen: true);
    final scheduleViewModel = Provider.of<ScheduleViewModel>(context);
    final teamNameViewModel = Provider.of<TeamNameViewModel>(context);
    final List<Team> teamList = teamViewModel.getTournamentTeams(tournamentId!);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            generateSchedule(tournamentId, teamList, teamViewModel,
                scheduleViewModel, teamNameViewModel);
            setState(() {

            });
          },
          child: const Text('Generate Schedule'),
        ),
        Expanded(
          flex: 3,
          child: Consumer<ScheduleViewModel>(
            builder: (context, viewModel, _) {
              final scheduleList = viewModel.getScheduleList(tournamentId);

              return ListView.builder(
                  itemCount: scheduleList.length,
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
                            onTap:(){
                              print(scheduleList[index].id);
                            },
                            child: Card(
                              elevation: 2,
                              color: AppColor.cardGrey,
                              child: ListTile(
                                title: Text(
                                 scheduleList[index].team1Name!,
                                  style: TextStyles.teamCardText,
                                ),
                                trailing:Text(
                                  scheduleList[index].team2Name!,
                                  style: TextStyles.teamCardText,
                                ),
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

void generateSchedule(
    int? tournamentId,
    List<Team> teamList,
    TeamViewModel teamViewModel,
    ScheduleViewModel scheduleViewModel,
    TeamNameViewModel teamNameViewModel) async{
  List<Team> getTeams = teamList;
  getTeams.shuffle();

  if (teamList.length % 2 != 0) {
   await teamViewModel.addTeam(
        tournamentId!, Team(teamName: 'Bye', tournamentId: tournamentId));
  }
  int newTeamLength = getTeams.length ~/ 2;

  List<Team> pole1 = getTeams.sublist(0, newTeamLength);
  List<Team> pole2 = getTeams.sublist(newTeamLength);
  print(pole1.length);
  print(pole2.length);
  for (int i = 0; i < pole1.length && i < pole2.length; i++) {
       await  teamNameViewModel.getTeamName(pole1[i].id!);
       final team1Name = teamNameViewModel.selectedTeam2;
       await teamNameViewModel.getTeamName(pole2[i].id!);
       final team2Name = teamNameViewModel.selectedTeam2;
      MatchSchedule newMatchSchedule = MatchSchedule(
          tournamentId: tournamentId,
          team1Id: pole1[i].id!,
          team2Id: pole2[i].id,
      team1Name: team1Name,
      team2Name: team2Name);
      scheduleViewModel.addSchedule(
          tournamentId!, pole1[i].id!, pole2[i].id!,team1Name, team2Name, newMatchSchedule);
  }
}
