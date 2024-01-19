import 'package:flutter/material.dart';
import 'package:football_host/data/model/tournament_model.dart';
import 'package:football_host/view_model/tournament_view_model.dart';
import 'package:provider/provider.dart';
import '../resources/app_colors.dart';
import '../resources/utils/responsive.dart';
import '../resources/utils/text_styles.dart';
import '../resources/utils/utils.dart';

class AddTournament extends StatelessWidget {
  const AddTournament({super.key});



  @override
  Widget build(BuildContext context) {
    TextEditingController tournamentNameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: const Text(
          'Tournament',
          style: TextStyles.appBarText,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: tournamentNameController,
              decoration: InputDecoration(
                hintText: 'Tournament Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              )
            ),
          ),
          InkWell(
            onTap: () async{
              TournamentViewModel tournamentViewModel = Provider.of<TournamentViewModel>(context, listen: false);
              String tournamentName = tournamentNameController.text;
              if(tournamentName.isNotEmpty){
                Tournament newTournament = Tournament(id: 0, name: tournamentName, team: []);
                tournamentViewModel.addTournament(newTournament);
                await Utils.toastMessage('Tournament Added Successfully');
                Navigator.pop(context);
              }


            },
            child: Container(
              height: Responsive.screenHeight(context) * 0.07,
              width: Responsive.screenWidth(context) * 0.7,
              decoration: BoxDecoration(
                  color: AppColor.appBarColor,
                  borderRadius: BorderRadius.circular(12)),
              child: const Center(
                  child: Text(
                      'Add Tournament',
                      style: TextStyles.buttonText,
                    )

              ),
            ),
          ),
        ],
      ),
    );
  }
}
