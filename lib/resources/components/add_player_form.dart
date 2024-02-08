import 'package:flutter/material.dart';
import 'package:football_host/data/model/player_model.dart';
import 'package:football_host/resources/app_colors.dart';
import 'package:football_host/resources/utils/responsive.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/resources/utils/utils.dart';
import 'package:football_host/view_model/player_view_model.dart';
import 'package:football_host/view_model/teamViewModel/teamName_view_model.dart';
import 'package:football_host/view_model/tournamentName_view_model.dart';
import 'package:provider/provider.dart';
import '../../view_model/teamViewModel/team_view_model.dart';
import '../utils/text_styles.dart';

class AddPlayerForm extends StatefulWidget {
  const AddPlayerForm({super.key});

  @override
  State<AddPlayerForm> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<AddPlayerForm> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: 1,
      child: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          tooltip: 'Add Player',
          backgroundColor: AppColor.appBarColor,
          onPressed: () {
            _displayTextField(context);
          },
          child: const Icon(
            Icons.add,
            color: AppColor.backGroundColor,
          )),
    );
  }
}

_displayTextField(BuildContext context) {
  final TextEditingController playerNameController = TextEditingController();
  final TextEditingController playerPosition = TextEditingController();
  final TextEditingController playerJerseyNo = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        final teamNameProvider =
            Provider.of<TeamNameViewModel>(context, listen: false);
        final playerProvider = Provider.of<PlayerViewModel>(context, listen: false);
        return Padding(
          padding: EdgeInsets.only(
              top: Responsive.screenWidth(context) * 0.2,
              bottom: Responsive.screenWidth(context) * 0.2),
          child: SingleChildScrollView(
            child: AlertDialog(
              elevation: 2,
              backgroundColor: AppColor.backGroundColor,
              title: const Text(
                'Enter Player Details',
                style: TextStyle(color: AppColor.appBarColor),
              ),
              content: Column(
                children: [
                  TextField(
                    controller: playerNameController,
                    decoration: InputDecoration(
                        hintText: 'Player Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  horizontalSpacing(space: 8),
                  TextField(
                    controller: playerPosition,
                    decoration: InputDecoration(
                        hintText: 'Position',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  horizontalSpacing(space: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: playerJerseyNo,
                    decoration: InputDecoration(
                        hintText: 'Jersey No',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      final String playerName =
                          playerNameController.text.trim();
                      final String jerseyNo = playerJerseyNo.text.trim();
                      final String position = playerPosition.text.trim();

                      final int? teamId = teamNameProvider.selectedTeamId;
                      if (playerName.isNotEmpty &&
                          jerseyNo.isNotEmpty &&
                          position.isNotEmpty) {
                        playerProvider.addPlayer(teamId!, playerName, position, int.tryParse(jerseyNo)!);
                        Navigator.pop(context);
                        await Utils.toastMessage("Player added successfully");

                        playerNameController.clear();
                        playerJerseyNo.clear();
                        playerPosition.clear();
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColor.appBarColor)),
                    child: const Text(
                      'Add',
                      style: TextStyles.buttonText,
                    ))
              ],
            ),
          ),
        );
      });
}
