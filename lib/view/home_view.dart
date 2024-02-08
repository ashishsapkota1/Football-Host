import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/resources/utils/images.dart';
import 'package:football_host/resources/utils/responsive.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/view_model/home_view_model.dart';
import 'package:football_host/view_model/tournamentName_view_model.dart';
import 'package:football_host/view_model/tournament_view_model.dart';
import 'package:provider/provider.dart';
import '../resources/utils/routes/routes_name.dart';
import '../resources/utils/text_styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final imageModel = Provider.of<HomeViewModel>(context);
    TournamentViewModel tournament = Provider.of<TournamentViewModel>(context);
     setState(() {
       tournament.getTournaments();
     });
     final tournaments = tournament.tournamentList;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: const Text(
          'Football Host',
          style: TextStyles.appBarText,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child:  ListView.builder(
          itemCount: tournaments.length,
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
                      final tournamentNameModel = Provider.of<TournamentNameViewModel>(context, listen: false);
                      final selectedTournament = tournaments[index];
                      tournamentNameModel.setSelectedTournament(selectedTournament.name!);
                      tournamentNameModel.setSelectedTournamentId(selectedTournament.id!);
                      Navigator.pushNamed(context, RoutesName.addTeams, arguments: selectedTournament.name);
                    },
                    child: Card(
                      elevation: 2,
                      color: AppColor.cardGrey,
                      child: ListTile(
                        title: Text(tournaments[index].name ?? '', style: TextStyles.cardText,),
                      ),
                    ),
                  ),
                ),
              ],
            );
          })
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Responsive.screenWidth(context) * 0.04,
              right: Responsive.screenWidth(context) * 0.04,
              bottom: Responsive.screenHeight(context) * 0.02,
            ),
            child: InkWell(
              onTap: () async{
                imageModel.onTapped();
                 await Navigator.pushNamed(context, RoutesName.addTournament);

                 imageModel.resetTapped();
              },
              child: Container(
                height: Responsive.screenHeight(context) * 0.07,
                width: Responsive.screenWidth(context) * 1,
                decoration: BoxDecoration(
                  color: AppColor.appBarColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      verticalSpacing(space: 6),
                      Image.asset(
                        imageModel.isTapped
                            ? Images.tappedWhistle
                            : Images.unTappedWhistle,
                        scale: 0.1,
                        height: Responsive.screenHeight(context) * 0.045,
                        color: imageModel.isTapped
                            ? Colors.grey
                            : AppColor.backGroundColor,
                      ),
                      verticalSpacing(space: 8),
                      const Text(
                        'Start a New Tournament',
                        style: TextStyles.buttonText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
