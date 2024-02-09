import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/routes/routes_name.dart';
import 'package:football_host/view_model/matchViewModel/match_view_model.dart';
import 'package:provider/provider.dart';
import '../../resources/app_colors.dart';
import '../../resources/utils/responsive.dart';
import '../../resources/utils/text_styles.dart';
import '../../view_model/tournamentName_view_model.dart';

class TournamentMatches extends StatefulWidget {
  const TournamentMatches({super.key});

  @override
  State<TournamentMatches> createState() => _TournamentMatchesState();
}

class _TournamentMatchesState extends State<TournamentMatches> {
  @override
  Widget build(BuildContext context) {
    final getTournamentId = Provider.of<TournamentNameViewModel>(context);
    final tournamentId = getTournamentId.selectedTournamentId;

    return Column(
      children: [
        Expanded(
          child: Consumer<MatchViewModel>(
            builder: (context, viewModel, _) {
              viewModel.getMatches(tournamentId!);
              final matchesList = viewModel.matches;
              if (matchesList.isEmpty) {
                return const Center(
                    child: Text(
                  'Confirm match from schedule',
                  style: TextStyles.cardText,
                ));
              } else {
                return ListView.builder(
                    itemCount: matchesList.length,
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
                                print(matchesList[index].team1Name);
                                Navigator.pushNamed(
                                    context, RoutesName.startMatch);
                              },
                              child: Card(
                                elevation: 2,
                                color: AppColor.cardGrey,
                                child: ListTile(
                                  title: Text(
                                    '${matchesList[index].team1Name ?? ''.toUpperCase()} vs ${matchesList[index].team2Name ?? ''.toUpperCase()}',
                                    style: TextStyles.teamCardText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              }
            },
          ),
        ),
      ],
    );
  }
}
