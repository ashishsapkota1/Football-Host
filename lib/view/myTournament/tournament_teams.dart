// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../view_model/tournament_view_model.dart';
//
// class TournamentTeams extends StatefulWidget {
//   final String tournamentId;
//   const TournamentTeams({super.key, required this.tournamentId});
//
//   @override
//   State<TournamentTeams> createState() => _TournamentTeamsState();
// }
//
// class _TournamentTeamsState extends State<TournamentTeams> {
//   @override
//   Widget build(BuildContext context) {
//     print('Tournament ID in Teams widget: ${widget.tournamentId}');
//     return Consumer<TournamentViewModel>(builder: (context, teamViewModel, _) {
//       // final teams = teamViewModel.tournamentsMap[widget.tournamentId];
//         return ListView.builder(
//           itemCount: teams.teams.length,
//           itemBuilder: (context, index) {
//             // final team = teams.teams[index];
//             return ListTile(
//               title: Text(team.name),
//             );
//           },
//         );
//     });
//   }
// }


import 'package:flutter/material.dart';

class TournamentTeams extends StatelessWidget {
  const TournamentTeams({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
