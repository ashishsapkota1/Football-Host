// import 'package:flutter/material.dart';
// import 'package:football_host/resources/components/floating_button.dart';
// import 'package:football_host/view_model/navbar_view_model.dart';
// import 'package:football_host/view_model/tournamentName_view_model.dart';
// import 'package:provider/provider.dart';
// import '../resources/app_colors.dart';
// import '../resources/utils/responsive.dart';
// import '../resources/utils/text_styles.dart';
// import 'myTournament/tournament_matches.dart';
// import 'myTournament/tournament_teams.dart';
//
// class AddTeams extends StatefulWidget {
//
//   // final Tournament? tournament;
//   const AddTeams({super.key});
//
//   @override
//   State<AddTeams> createState() => _AddTeamsState();
// }
//
// class _AddTeamsState extends State<AddTeams> {
//   late List<Widget> currentTab;
//   @override
//   Widget build(BuildContext context) {
//     final getTournamentName =
//         Provider.of<TournamentNameViewModel>(context, listen: false);
//     final String tournamentName = getTournamentName.selectedTournament;
//     final String tournamentId =  Provider.of<TournamentNameViewModel>(context)
//         .selectedTournamentId;
//     print(tournamentId);
//
//     currentTab = [
//       TournamentTeams(),
//
//       const TournamentMatches()
//     ];
//     return Scaffold(
//         backgroundColor: AppColor.backGroundColor,
//         appBar: AppBar(
//           backgroundColor: AppColor.appBarColor,
//           title: Text(
//             tournamentName,
//             style: TextStyles.appBarText,
//           ),
//           centerTitle: true,
//         ),
//         body: Consumer<NavbarViewModel>(
//           builder: (context, bottomNavBarViewModel, _) {
//             // Display different content based on the selected item
//         ),
//         // floatingActionButton: Padding(
//         //   padding:
//         //       EdgeInsets.only(bottom: Responsive.screenHeight(context) * 0.1),
//         //   child: FloatingButton(),
//         // ),
//         // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//         bottomNavigationBar:
//             Consumer<NavbarViewModel>(builder: (context, navBar, _) {
//           currentTab[navBar.selectedItem];
//           return BottomNavigationBar(
//               selectedItemColor: AppColor.appBarColor,
//               currentIndex: navBar.selectedItem,
//               onTap: (index) {
//                 navBar.setSelectedItem = index;
//               },
//               items: const <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.group),
//                   label: 'Teams',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.scoreboard),
//                   label: 'Matches',
//                 ),
//               ]);
//         }));
//   }
// }
