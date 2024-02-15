import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/spacing.dart';
import 'package:football_host/view/match-view/formation/formation.dart';
import 'package:football_host/view/match-view/playing11/playingXiTeam1.dart';
import 'package:football_host/view/match-view/playing11/playingXiTeam2.dart';
import '../../resources/app_colors.dart';
import '../../resources/utils/text_styles.dart';

class LineUp extends StatefulWidget {
  final int? team1Id;
  final int? team2Id;
  const LineUp({Key? key, required this.team1Id, required this.team2Id}) : super(key: key);

  @override
  State<LineUp> createState() => _LineUpState();
}

class _LineUpState extends State<LineUp> {
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
      Offset(0.42, 0.02),
      Offset(0.05, 0.10),
      Offset(0.3, 0.10),
      Offset(0.55, 0.10),
      Offset(0.8, 0.10),
      Offset(0.09, 0.20),
      Offset(0.45, 0.20),
      Offset(0.8, 0.20),
      Offset(0.09, 0.30),
      Offset(0.45, 0.30),
      Offset(0.8, 0.30),
    ],
    '3-4-3': const [
      Offset(0.42, 0.02),
      Offset(0.09, 0.10),
      Offset(0.42, 0.10),
      Offset(0.78,0.10),
      Offset(0.06, 0.20),
      Offset(0.3,0.20),
      Offset(0.58, 0.20),
      Offset(0.8, 0.20),
      Offset(0.09, 0.30),
      Offset(0.45, 0.30),
      Offset(0.8, 0.30),

    ],

    '4-4-2': const [
      Offset(0.42, 0.02),
      Offset(0.05, 0.10),
      Offset(0.3, 0.10),
      Offset(0.55, 0.10),
      Offset(0.8, 0.10),
      Offset(0.06, 0.20),
      Offset(0.3, 0.20),
      Offset(0.58, 0.20),
      Offset(0.8, 0.20),
      Offset(0.25, 0.30),
      Offset(0.65, 0.30),
    ],
    '4-3-2-1':const  [
      Offset(0.42, 0.02),
      Offset(0.05, 0.10),
      Offset(0.3, 0.10),
      Offset(0.55, 0.10),
      Offset(0.8, 0.10),
      Offset(0.09, 0.18),
      Offset(0.42, 0.18),
      Offset(0.8, 0.18),
      Offset(0.22, 0.26),
      Offset(0.65, 0.26),
      Offset(0.42, 0.30),
    ],
  };

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
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
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
          ),
          horizontalSpacing(space: 8),
          PlayingXiTeam1(teamId: widget.team1Id),
          _buildFormation1(dropDownValue1),
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
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
          ),
          horizontalSpacing(space: 8),
          PlayingXiTeam2(teamId: widget.team2Id),
          _buildFormation2(dropDownValue2),
        ],
      ),
    );
  }

  Widget _buildFormation1(String value1) {
    List<Offset> positions = formationPositions[value1] ?? [];
    return value1 == '4-3-3'
        ?  FormationNo1(teamId: widget.team1Id,quarterTurn: 4, positions: positions, avatarQuarterTurn: 4,)
        : value1 == '3-4-3'
        ?  FormationNo1(quarterTurn: 4, positions: positions, avatarQuarterTurn: 4,)
        : value1 == '4-4-2'
        ?  FormationNo1(quarterTurn: 4, positions: positions, avatarQuarterTurn: 4,)
        :  FormationNo1(quarterTurn: 4, positions: positions, avatarQuarterTurn: 4,);
  }

  Widget _buildFormation2(String value2) {
    List<Offset> positions = formationPositions[value2] ?? [];
    return value2 == '4-3-3'
        ?  FormationNo1(teamId: widget.team2Id,quarterTurn: 2, positions: positions, avatarQuarterTurn: 2,)
        : value2 == '3-4-3'
        ?  FormationNo1(quarterTurn: 2, positions: positions, avatarQuarterTurn: 2,)
        : value2 == '4-4-2'
        ?  FormationNo1(quarterTurn: 2, positions: positions, avatarQuarterTurn: 2,)
        :  FormationNo1(quarterTurn: 2, positions: positions, avatarQuarterTurn: 2,);
  }
}
