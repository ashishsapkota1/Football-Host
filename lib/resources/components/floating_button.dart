import 'package:flutter/material.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/resources/utils/utils.dart';
import 'package:football_host/view_model/tournamentName_view_model.dart';
import 'package:football_host/view_model/tournament_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../utils/text_styles.dart';

class FloatingButton extends StatelessWidget {
  FloatingButton({super.key});

  TextEditingController _addTeamsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Add Team',
      backgroundColor: AppColor.appBarColor,
      onPressed: () {
        _displayTextField(context, _addTeamsController);
      },
      child: const Icon(
        Icons.add,
        color: AppColor.backGroundColor,
      ),
    );
  }
}

_displayTextField(BuildContext context, TextEditingController _controller) {
  return showDialog(
      context: context,
      builder: (context) {
        final tournamentNameProvider = Provider.of<TournamentNameViewModel>(context, listen: false);
        final tournamentProvider = Provider.of<TournamentViewModel>(context, listen: false);
        return AlertDialog(
          backgroundColor: AppColor.backGroundColor,
          title: const Text('Enter Team Name',style: TextStyle(color: AppColor.appBarColor),),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
                hintText: 'Team Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          actions: [ElevatedButton(
              onPressed: () async{
                final String teamName = _controller.text;
                final  int? tournamentId = tournamentNameProvider.selectedTournamentId;

                tournamentProvider.addTeamToTournament(tournamentId , newTeam);
                print(tournamentId);
                print(newTeam.id);

                await Utils.toastMessage('Team Added Successfully');
                Navigator.pop(context);


              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppColor.appBarColor)
              ),
              child: const Text('Add',style: TextStyles.buttonText,))],
        );
      });
}


