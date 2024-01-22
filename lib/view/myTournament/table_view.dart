

import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/responsive.dart';
import 'package:football_host/view_model/teamViewModel/team_view_model.dart';
import 'package:football_host/view_model/tournamentName_view_model.dart';
import 'package:provider/provider.dart';

import '../../data/model/team_model.dart';

class TournamentTable extends StatelessWidget {
  const TournamentTable({super.key});

  @override
  Widget build(BuildContext context) {
    final getTournamentId = Provider.of<TournamentNameViewModel>(context);
    final tournamentId = getTournamentId.selectedTournamentId;
    final List<Team> teamList =
        Provider.of<TeamViewModel>(context).getTournamentTeams(tournamentId!);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: DataTable(
            border: TableBorder.all(width: 0.5),
            columnSpacing: Responsive.screenWidth(context)*0.04,
            columns: const <DataColumn>[
              DataColumn(label: Text('TeamName')),
              DataColumn(label: Text('MP')),
              DataColumn(label: Text('W')),
              DataColumn(label: Text('D')),
              DataColumn(label: Text('L')),
              DataColumn(label: Text('P')),
              DataColumn(label: Text('GF')),
              DataColumn(label: Text('GA')),
              DataColumn(label: Text('GD')),
            ],
            rows: teamList.map((team) {
              return DataRow(cells: [
                DataCell(Text(team.teamName!)),
                DataCell(Text('0')),
                DataCell(Text('0')),
                DataCell(Text('0')),
                DataCell(Text('0')),
                DataCell(Text('0')),
                DataCell(Text('0')),
                DataCell(Text('0')),
                DataCell(Text('0'))
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
