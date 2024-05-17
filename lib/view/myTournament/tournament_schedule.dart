import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:football_host/data/model/match/match_model.dart';
import 'package:football_host/data/model/match/match_schedule_model.dart';
import 'package:football_host/data/model/tournament_model.dart';
import 'package:football_host/view_model/matchViewModel/match_view_model.dart';
import 'package:football_host/view_model/matchViewModel/schedule_view_model.dart';
import 'package:football_host/view_model/teamViewModel/teamName_view_model.dart';
import 'package:football_host/view_model/teamViewModel/team_view_model.dart';
import 'package:football_host/view_model/tournament_view_model.dart';
import 'package:provider/provider.dart';

import '../../data/model/team_model.dart';
import '../../resources/app_colors.dart';
import '../../resources/utils/responsive.dart';
import '../../resources/utils/text_styles.dart';
import '../../resources/utils/utils.dart';
import '../../view_model/tournamentName_view_model.dart';

class TournamentSchedule extends StatefulWidget {
  const TournamentSchedule({super.key});

  @override
  State<TournamentSchedule> createState() => _TournamentScheduleState();
}

class _TournamentScheduleState extends State<TournamentSchedule> {

  @override
  Widget build(BuildContext context) {
    final getTournamentId = Provider.of<TournamentNameViewModel>(context);
    final tournamentId = getTournamentId.selectedTournamentId;
    final teamViewModel = Provider.of<TeamViewModel>(context, listen: false);
    final scheduleViewModel =
        Provider.of<ScheduleViewModel>(context, listen: false);
    final matchViewModel = Provider.of<MatchViewModel>(context);
    final teamNameViewModel = Provider.of<TeamNameViewModel>(context);
    teamViewModel.getTournamentTeams(tournamentId!);
    final teamList = teamViewModel.tournamentTeams;
    TournamentViewModel tournamentViewModel =
        Provider.of<TournamentViewModel>(context);

    return Column(
      children: [
        Expanded(
          child: Consumer<ScheduleViewModel>(
            builder: (context, viewModel, _) {
              viewModel.getSchedule(tournamentId);
              final scheduleList = viewModel.scheduleList;
              if (scheduleList.isNotEmpty) {
                Map<String, List<Schedule>> groupedSchedules = {};
                for (var schedule in scheduleList) {
                  if (!groupedSchedules.containsKey(schedule.roundName ?? '')) {
                    groupedSchedules[schedule.roundName ?? ''] = [];
                  }
                  groupedSchedules[schedule.roundName ?? '']!.add(schedule);
                }

                return ListView(
                  children: groupedSchedules.entries
                      .map(
                        (entry) => Padding(
                          padding: EdgeInsets.only(
                            left: Responsive.screenWidth(context) * 0.02,
                            right: Responsive.screenWidth(context) * 0.02,
                            top: Responsive.screenHeight(context) * 0.01,
                          ),
                          child: ListTile(
                            title: Text(
                              " ${entry.key}",
                              style: TextStyles.roundNameText,
                            ),
                            subtitle: Column(
                              children: entry.value
                                  .map(
                                    (schedule) => ListView(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: [
                                          const Divider(
                                            thickness: 2,
                                          ),
                                          InkWell(
                                            highlightColor: AppColor.cardGrey,
                                            onTap: () async {
                                              bool alreadyAdded = matchViewModel
                                                  .matchAlreadyAdded(
                                                      schedule.id!);
                                              if (alreadyAdded) {
                                                Utils.flushBarErrorMessage(
                                                    'Match already added',
                                                    context);
                                              } else {
                                                AlertDialog alert = AlertDialog(
                                                  title: const Text(
                                                    'Add to matches',
                                                    style:
                                                        TextStyles.scheduleText,
                                                  ),
                                                  content: const Text(
                                                    'confirm to add',
                                                    style:
                                                        TextStyles.teamCardText,
                                                  ),
                                                  actions: [
                                                    Row(
                                                      children: [
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              Matches matches = Matches(
                                                                  tournamentId:
                                                                      tournamentId,
                                                                  scheduleId:
                                                                      schedule
                                                                          .id,
                                                                  team1Id: schedule
                                                                      .team1Id,
                                                                  team2Id: schedule
                                                                      .team2Id,
                                                                  team1Name:
                                                                      schedule
                                                                          .team1Name,
                                                                  team2Name:
                                                                      schedule
                                                                          .team2Name,
                                                                  team1Score: 0,
                                                                  team2Score: 0,
                                                                  penaltyScore:
                                                                      '');
                                                              Navigator.pop(
                                                                  context);
                                                              await matchViewModel
                                                                  .addMatches(
                                                                      schedule
                                                                          .tournamentId!,
                                                                      matches);
                                                            },
                                                            child: const Text(
                                                                'Confirm',
                                                                style: TextStyles
                                                                    .confirmText)),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Cancel',
                                                                style: TextStyles
                                                                    .cancelText))
                                                      ],
                                                    )
                                                  ],
                                                );
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return alert;
                                                    });
                                              }
                                            },
                                            child: Text(
                                              "${schedule.team1Name?.isNotEmpty ?? false ? schedule.team1Name!.toUpperCase() : 'TBD'} vs ${schedule.team2Name?.isNotEmpty ?? false ? schedule.team2Name!.toUpperCase() : 'TBD'}",
                                              style: TextStyles.scheduleText,
                                            ),
                                          ),
                                        ]),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              } else {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        generateSchedule(
                            tournamentId,
                            teamList,
                            teamViewModel,
                            scheduleViewModel,
                            teamNameViewModel,
                            tournamentViewModel);
                        setState(() {});
                      },
                      child: const Text('Generate Schedule'),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

Future<void> generateSchedule(
    int tournamentId,
    List<Team> teamList,
    TeamViewModel teamViewModel,
    ScheduleViewModel scheduleViewModel,
    TeamNameViewModel teamNameViewModel,
    TournamentViewModel tournamentViewModel) async {
  List<String> allTeams = [];
  List<Schedule> allSchedules = [];
  for (var oneTeam in teamList) {
    allTeams.add('team-${oneTeam.id!}');
  }
  allTeams.shuffle();
  int matchNumber = 1;
  int noOfTeams = allTeams.length;
  int noOfRounds = (log(noOfTeams) ~/ log(2)).floor();
  int a = (noOfTeams ~/ 2).toInt();
  List<String> pole1 = allTeams.sublist(0, a);
  List<String> pole2 = allTeams.sublist(a);
  pole1.shuffle();
  pole2.shuffle();
  int remainingRound = noOfRounds - 1;

  // Preliminary Round
  Map<String, Map<String, List<String>>> allRoundTeams = {};
  allRoundTeams["prTeams"] = {'pole1': pole1, 'pole2': pole2};

  final tournaments = tournamentViewModel.tournamentList;
  Tournament thisTournament =
      tournaments.firstWhere((obj) => obj.id == tournamentId);
  await tournamentViewModel.insertPolesToTournament(
      thisTournament, jsonEncode(allRoundTeams["prTeams"]));

  allRoundTeams["round1Teams"] = {'pole1': [], 'pole2': []};
  for (int i = 0; i < 2; i++) {
    List<String>? poleTeams = allRoundTeams["prTeams"]?['pole${i + 1}'];
    int poleDiff = poleTeams!.length -
        pow(
                2,
                (log(allRoundTeams["prTeams"]?["pole1"]?.length as num) ~/
                        log(2))
                    .floor())
            .toInt();
    if (poleDiff > 0) {
      for (int m = 0; m < poleDiff; m++) {
        String? x = poleTeams[2 * m];
        String? y = poleTeams[2 * m + 1];
        List<String> xValues = x.split('-');
        List<String> yValues = y.split('-');
        String team1Name = '';
        String team2Name = '';
        if (xValues[0] == 'team') {
          await teamNameViewModel.getTeamName(int.tryParse(xValues[1]) ?? 0);
          team1Name = teamNameViewModel.selectedTeam2;
        }
        if (yValues[0] == 'team') {
          await teamNameViewModel.getTeamName(int.tryParse(yValues[1]) ?? 0);
          team2Name = teamNameViewModel.selectedTeam2;
        }
        Schedule newSchedule = Schedule(
            tournamentId: tournamentId,
            team1Id: (xValues[0] == 'team') ? int.tryParse(xValues[1]) : 0,
            team2Id: (yValues[0] == 'team') ? int.tryParse(yValues[1]) : 0,
            team1Name: team1Name,
            team2Name: team2Name,
            team1DependsOn: (xValues[0] == 'match') ? int.parse(xValues[1]) : 0,
            team2DependsOn: (yValues[0] == 'match') ? int.parse(yValues[1]) : 0,
            matchNumber: matchNumber,
            roundNumber: 0,
            roundName: 'Preliminary');
        allSchedules.add(newSchedule);
        // await scheduleViewModel.addSchedule(tournamentId, newSchedule);
        allRoundTeams["round1Teams"]?['pole${i + 1}']
            ?.add('match-$matchNumber');
        matchNumber++;
      }
      allRoundTeams["round1Teams"]?['pole${i + 1}']
          ?.addAll(poleTeams.sublist(2 * poleDiff));
    } else {
      allRoundTeams["round1Teams"]?['pole${i + 1}'] = poleTeams;
    }
  }

  // Other Rounds
  for (int round = 0; round < noOfRounds; round++) {
    String roundName = (remainingRound == 2)
        ? 'QuarterFinal'
        : (remainingRound == 1)
            ? 'SemiFinal'
            : (remainingRound == 0)
                ? 'Final'
                : 'Round-${round + 1}';

    int noOfMatchesInAPole = (pow(2, remainingRound) / 2).ceil();
    if (remainingRound != 0) {
      Map<String, List<String>> nextRoundTeams = {'pole1': [], 'pole2': []};
      for (int p = 0; p < 2; p++) {
        for (int match = 0; match < noOfMatchesInAPole; match++) {
          String? x = allRoundTeams["round${round + 1}Teams"]?['pole${p + 1}']
              ?[2 * match];
          String? y = allRoundTeams["round${round + 1}Teams"]?['pole${p + 1}']
              ?[2 * match + 1];
          List<String> xValues = x!.split('-');
          List<String> yValues = y!.split('-');
          String team1Name = '';
          String team2Name = '';
          if (xValues[0] == 'team') {
            await teamNameViewModel.getTeamName(int.tryParse(xValues[1]) ?? 0);
            team1Name = teamNameViewModel.selectedTeam2;
          }
          if (yValues[0] == 'team') {
            await teamNameViewModel.getTeamName(int.tryParse(yValues[1]) ?? 0);
            team2Name = teamNameViewModel.selectedTeam2;
          }
          Schedule newSchedule = Schedule(
              tournamentId: tournamentId,
              team1Id: (xValues[0] == 'team') ? int.tryParse(xValues[1]) : 0,
              team2Id: (yValues[0] == 'team') ? int.tryParse(yValues[1]) : 0,
              team1Name: team1Name,
              team2Name: team2Name,
              team1DependsOn:
                  (xValues[0] == 'match') ? int.parse(xValues[1]) : 0,
              team2DependsOn:
                  (yValues[0] == 'match') ? int.parse(yValues[1]) : 0,
              matchNumber: matchNumber,
              roundNumber: round + 1,
              roundName: roundName);
          // await scheduleViewModel.addSchedule(tournamentId, newSchedule);
          allSchedules.add(newSchedule);
          nextRoundTeams['pole${p + 1}']!.add('match-$matchNumber');
          matchNumber++;
        }
      }
      allRoundTeams["round${round + 2}Teams"] = nextRoundTeams;
    } else {
      List<String> x =
          allRoundTeams['round${round + 1}Teams']!['pole1']![0].split('-');
      List<String?> y =
          allRoundTeams['round${round + 1}Teams']!['pole2']!.isNotEmpty
              ? allRoundTeams['round${round + 1}Teams']!['pole2']![0].split('-')
              : [];
      String team1Name = '';
      String team2Name = '';
      if (x[0] == 'team') {
        await teamNameViewModel.getTeamName(int.tryParse(x[1]) ?? 0);
        team1Name = teamNameViewModel.selectedTeam2;
      }
      if (y.isNotEmpty && y[0] == 'team') {
        await teamNameViewModel.getTeamName(int.tryParse(y[1]!) ?? 0);
        team2Name = teamNameViewModel.selectedTeam2;
      }
      Schedule newSchedule = Schedule(
          tournamentId: tournamentId,
          team1Id: (x[0] == 'team') ? int.tryParse(x[1]) : 0,
          team2Id: (y[0] != null && y[0] == 'team') ? int.tryParse(y[1]!) : 0,
          team1Name: team1Name,
          team2Name: team2Name,
          team1DependsOn: (x[0] == 'match') ? int.parse(x[1]) : 0,
          team2DependsOn:
              (y.isNotEmpty && y[0] == 'match') ? int.parse(y[1]!) : 0,
          matchNumber: matchNumber,
          roundNumber: round + 1,
          roundName: roundName);
      allSchedules.add(newSchedule);
      // await scheduleViewModel.addSchedule(tournamentId, newSchedule);
      matchNumber++;
    }
    remainingRound--;
  }
  print(allSchedules.length);
  addScheduleToDB(tournamentId, allSchedules, scheduleViewModel);
}

void addScheduleToDB(int tourId, List<Schedule> allSchedules,
    ScheduleViewModel scheduleViewModel) async {
  for (int i = 0; i < allSchedules.length; i++) {
    await scheduleViewModel.addSchedule(tourId, allSchedules[i]);
  }
}
