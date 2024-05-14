import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/resources/utils/utils.dart';
import 'package:football_host/view/match-view/formation/formation.dart';
import 'package:football_host/view/match-view/playing11/playingXiTeam1.dart';
import 'package:football_host/view/match-view/playing11/playingXiTeam2.dart';
import 'package:football_host/view_model/matchViewModel/match_timer_model.dart';
import 'package:football_host/view_model/matchViewModel/match_view_model.dart';
import 'package:football_host/view_model/tournamentName_view_model.dart';
import 'package:provider/provider.dart';
import '../../resources/app_colors.dart';
import '../../resources/utils/text_styles.dart';

class LineUp extends StatefulWidget {
  final int? matchId;
  final int? team1Id;
  final int? team2Id;
  final String? team1Name;
  final String? team2Name;

  const LineUp(
      {Key? key,
      required this.matchId,
      required this.team1Id,
      required this.team2Id,
      required this.team1Name,
      required this.team2Name})
      : super(key: key);

  @override
  State<LineUp> createState() => _LineUpState();
}

class _LineUpState extends State<LineUp> {
  final TextEditingController timeController = TextEditingController();
  static const List<String> list = <String>[
    '4-3-3',
    '3-4-3',
    '4-4-2',
    '4-3-2-1'
  ];
  String dropDownValue1 = list.first;
  String dropDownValue2 = list.first;

  final Map<String, List<Offset>> formationPositions = {
    '4-3-3': const [
      Offset(0.42, 0.09),
      Offset(0.05, 0.18),
      Offset(0.3, 0.18),
      Offset(0.55, 0.18),
      Offset(0.8, 0.18),
      Offset(0.09, 0.27),
      Offset(0.42, 0.27),
      Offset(0.75, 0.27),
      Offset(0.09, 0.36),
      Offset(0.42, 0.36),
      Offset(0.75, 0.36),
    ],
    '3-4-3': const [
      Offset(0.42, 0.09),
      Offset(0.09, 0.18),
      Offset(0.42, 0.18),
      Offset(0.78, 0.18),
      Offset(0.06, 0.27),
      Offset(0.3, 0.27),
      Offset(0.58, 0.27),
      Offset(0.8, 0.27),
      Offset(0.09, 0.36),
      Offset(0.42, 0.36),
      Offset(0.8, 0.36),
    ],
    '4-4-2': const [
      Offset(0.42, 0.09),
      Offset(0.05, 0.18),
      Offset(0.3, 0.18),
      Offset(0.55, 0.18),
      Offset(0.8, 0.18),
      Offset(0.06, 0.27),
      Offset(0.3, 0.27),
      Offset(0.58, 0.27),
      Offset(0.8, 0.27),
      Offset(0.25, 0.36),
      Offset(0.65, 0.36),
    ],
    '4-3-2-1': const [
      Offset(0.42, 0.09),
      Offset(0.05, 0.17),
      Offset(0.3, 0.17),
      Offset(0.55, 0.17),
      Offset(0.8, 0.17),
      Offset(0.09, 0.26),
      Offset(0.42, 0.26),
      Offset(0.8, 0.26),
      Offset(0.22, 0.33),
      Offset(0.65, 0.33),
      Offset(0.42, 0.37),
    ],
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = AudioPlayer();
    final getTournamentId =
        Provider.of<TournamentNameViewModel>(context, listen: false);
    int? matchId = getTournamentId.selectedMatchId;
    final matchTimerViewModel =
        Provider.of<MatchTimerViewModel>(context, listen: false);

    return Consumer<MatchViewModel>(builder: (context, viewModel, _) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const Text('Select formation'),
            DropdownButton(
              style: TextStyles.cardText,
              elevation: 4,
              iconEnabledColor: AppColor.appBarColor,
              borderRadius: BorderRadius.circular(8),
              value: dropDownValue1,
              onChanged: (String? value) {
                setState(() {
                  dropDownValue1 = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
            ),
            horizontalSpacing(space: 8),
            PlayingXiTeam1(teamId: widget.team1Id),
            _buildFormation1(dropDownValue1),
            const Text('Select formation'),
            DropdownButton(
              value: dropDownValue2,
              style: TextStyles.cardText,
              elevation: 4,
              iconEnabledColor: AppColor.appBarColor,
              borderRadius: BorderRadius.circular(8),
              onChanged: (String? value) {
                setState(() {
                  dropDownValue2 = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
            ),
            horizontalSpacing(space: 8),
            PlayingXiTeam2(teamId: widget.team2Id),
            _buildFormation2(dropDownValue2),
            horizontalSpacing(space: 14),
            Offstage(
              offstage: viewModel.hasStarted,
              child: !viewModel.isFirstHalf && !viewModel.isSecondHalf
                  ? viewModel.isFirstHalf ? const SizedBox() :Column(
                children: [
                  const Text('Enter the match time in minutes:'),
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Utils.toastMessage(
                                'Please enter the time', Colors.red);
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: timeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                  ),
                ],
              )
                  : const SizedBox()
            ),
            horizontalSpacing(space: 8),
            Offstage(
                offstage: viewModel.hasStarted,
                child: viewModel.isFirstHalf && viewModel.isSecondHalf
                    ? const SizedBox()
                    : TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.appBarColor),
                        ),
                        onPressed: () async {
                          if(viewModel.isFirstHalf == false) {
                            if (_formKey.currentState!.validate()) {
                              const path = "sound/whistle.mp3";
                              int matchTime1 = int.parse(timeController.text);
                              await audioPlayer.play(AssetSource(path));
                              await viewModel.matchStarted(widget.matchId!,
                                  true);
                              await viewModel.addMatchTime(
                                  matchId!, matchTime1);
                              matchTimerViewModel.startTimer(
                                  (matchTime1 / 2).ceil(), widget.matchId!);
                              Utils.toastMessage(
                                  'FirstHalf has started', AppColor.appBarColor);
                            }
                          } else{
                            const path = "sound/whistle.mp3";
                            await audioPlayer.play(AssetSource(path));
                            await viewModel.matchStarted(widget.matchId!,
                                true);
                            int matchTime = viewModel.matchTime;
                            matchTimerViewModel.startTimer(
                                (matchTime / 2).ceil(), widget.matchId!);
                            Utils.toastMessage(
                                'SecondHalf has started', AppColor.appBarColor);

                          }
                        },
                        child: viewModel.isFirstHalf
                            ? const Text(
                                'Start second half',
                                style: TextStyles.tabBarStyle,
                              )
                            : const Text(
                                'Start first half',
                                style: TextStyles.tabBarStyle,
                              ))),
            horizontalSpacing(space: 8)
          ],
        ),
      );
    });
  }

  Widget _buildFormation1(String value1) {
    List<Offset> positions = formationPositions[value1] ?? [];
    return value1 == '4-3-3'
        ? FormationNo1(
            teamId: widget.team1Id,
            quarterTurn: 4,
            upperContainerQTurn: 4,
            positions: positions,
            avatarQuarterTurn: 4,
            teamName: widget.team1Name,
          )
        : value1 == '3-4-3'
            ? FormationNo1(
                teamId: widget.team1Id,
                quarterTurn: 4,
                upperContainerQTurn: 4,
                positions: positions,
                avatarQuarterTurn: 4,
                teamName: widget.team1Name,
              )
            : value1 == '4-4-2'
                ? FormationNo1(
                    teamId: widget.team1Id,
                    quarterTurn: 4,
                    upperContainerQTurn: 4,
                    positions: positions,
                    avatarQuarterTurn: 4,
                    teamName: widget.team1Name,
                  )
                : FormationNo1(
                    teamId: widget.team1Id,
                    quarterTurn: 4,
                    upperContainerQTurn: 4,
                    positions: positions,
                    avatarQuarterTurn: 4,
                    teamName: widget.team1Name,
                  );
  }

  Widget _buildFormation2(String value2) {
    List<Offset> positions = formationPositions[value2] ?? [];
    return value2 == '4-3-3'
        ? FormationNo1(
            teamId: widget.team2Id,
            quarterTurn: 2,
            upperContainerQTurn: 2,
            positions: positions,
            avatarQuarterTurn: 2,
            teamName: widget.team2Name,
          )
        : value2 == '3-4-3'
            ? FormationNo1(
                teamId: widget.team2Id,
                quarterTurn: 2,
                upperContainerQTurn: 2,
                positions: positions,
                avatarQuarterTurn: 2,
                teamName: widget.team2Name,
              )
            : value2 == '4-4-2'
                ? FormationNo1(
                    teamId: widget.team2Id,
                    quarterTurn: 2,
                    upperContainerQTurn: 2,
                    positions: positions,
                    avatarQuarterTurn: 2,
                    teamName: widget.team2Name,
                  )
                : FormationNo1(
                    teamId: widget.team2Id,
                    quarterTurn: 2,
                    upperContainerQTurn: 2,
                    positions: positions,
                    avatarQuarterTurn: 2,
                    teamName: widget.team2Name,
                  );
  }
}
