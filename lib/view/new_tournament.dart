import 'package:flutter/material.dart';
import 'package:football_host/data/model/tournament_model.dart';
import 'package:football_host/view_model/tournament_view_model.dart';
import 'package:provider/provider.dart';
import '../resources/app_colors.dart';
import '../resources/utils/responsive.dart';
import '../resources/utils/text_styles.dart';
import '../resources/utils/utils.dart';

class AddTournament extends StatefulWidget {
  const AddTournament({super.key});

  @override
  State<AddTournament> createState() => _AddTournamentState();
}

class _AddTournamentState extends State<AddTournament> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    TournamentViewModel tournamentViewModel = Provider.of<TournamentViewModel>(context, listen: false);
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
                controller: _controller,
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
              String tournamentName = _controller.text.trim();
              if(tournamentName.isNotEmpty){
                Navigator.pop(context);
                await tournamentViewModel.addTournament(tournamentName, '');
                await Utils.toastMessage('Tournament added', AppColor.backGroundColor);
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
