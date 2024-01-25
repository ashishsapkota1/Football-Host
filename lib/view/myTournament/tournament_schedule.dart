import 'package:flutter/material.dart';
import 'package:football_host/data/model/match/match_schedule_model.dart';
import 'package:football_host/view_model/matchViewModel/schedule_view_model.dart';
import 'package:provider/provider.dart';

import '../../resources/app_colors.dart';
import '../../resources/utils/responsive.dart';
import '../../resources/utils/text_styles.dart';
import '../../view_model/tournamentName_view_model.dart';

class TournamentSchedule extends StatelessWidget {
  const TournamentSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final getTournamentId = Provider.of<TournamentNameViewModel>(context);
    final tournamentId = getTournamentId.selectedTournamentId;
    final scheduleViewModel = Provider.of<ScheduleViewModel>(context);

    return Column(
      children: [
        ElevatedButton(onPressed: () {
          scheduleViewModel.generateAndInsertSchedule(tournamentId!);
          print(scheduleViewModel.schedule);

        }, child: const Text('Generate Schedule')),
        Expanded(
          child: Consumer<ScheduleViewModel>(
            builder: (context, viewModel, _) {
              List<MatchSchedule> scheduleList = viewModel.schedule;
              print(scheduleList.length);


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
                            onTap: () {
                              // final teamNameModel = Provider.of<TeamNameViewModel>(context, listen: false);
                              // final selectedTeamName = teamList[index].teamName;
                              // teamNameModel.setSelectedTeam(selectedTeamName!);
                              // final selectedTeamId = teamList[index].id;
                              // teamNameModel.setSelectedTeamId(selectedTeamId!);
                              // // Navigator.pushNamed(context, RoutesName.teamPlayers,arguments: selectedTeamName);
                              // print(selectedTeamId);
                            },
                            child: Card(
                              elevation: 2,
                              color: AppColor.cardGrey,
                              child: ListTile(
                                title: Text(scheduleList[index].team1Id!.toString(), style: TextStyles.teamCardText,),
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

