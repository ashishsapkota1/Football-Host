import 'package:flutter/material.dart';
import 'package:football_host/data/model/team_model.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/resources/utils/utils.dart';
import 'package:football_host/view_model/tournamentName_view_model.dart';
import 'package:provider/provider.dart';
import '../../view_model/teamViewModel/team_view_model.dart';
import '../utils/text_styles.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  final TextEditingController _addTeamsController = TextEditingController();

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

_displayTextField(BuildContext context, TextEditingController controller) {
  return showDialog(
      context: context,
      builder: (context) {
        final tournamentNameProvider = Provider.of<TournamentNameViewModel>(context, listen: false);
        final teamProvider = Provider.of<TeamViewModel>(context, listen: false);
        return AlertDialog(
          backgroundColor: AppColor.backGroundColor,
          title: const Text('Enter Team Name',style: TextStyle(color: AppColor.appBarColor),),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: 'Team Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          actions: [ElevatedButton(
              onPressed: () async{
                final String teamName = controller.text.trim();
                final  int? tournamentId = tournamentNameProvider.selectedTournamentId;

                if(teamName.isNotEmpty){
                  teamProvider.addTeam(tournamentId!, teamName);
                  Navigator.pop(context);
                  await Utils.toastMessage('teams added', Colors.red);

                  controller.clear();
                }



              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppColor.appBarColor)
              ),
              child: const Text('Add',style: TextStyles.buttonText,))],
        );
      });
}


