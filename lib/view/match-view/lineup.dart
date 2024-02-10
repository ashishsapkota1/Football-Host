import 'package:flutter/material.dart';
import 'package:football_host/view/match-view/formation/3-4-3.dart';
import 'package:football_host/view/match-view/formation/4-3-2-1.dart';
import 'package:football_host/view/match-view/formation/4-3-3.dart';
import 'package:football_host/view/match-view/formation/4-4-2.dart';
import '../../resources/app_colors.dart';
import '../../resources/utils/text_styles.dart';

class LineUp extends StatefulWidget {
  const LineUp({Key? key}) : super(key: key);

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
          dropDownValue1 == '4-3-3'
              ? const FormationNo1(
                  quarterTurn: 4,
                )
              : dropDownValue1 == '3-4-3'
                  ? const FormationNo2(quarterTurn: 4)
                  : dropDownValue1 == '4-4-2'
                      ? const FormationNo3(quarterTurn: 4)
                      : const FormationNo4(),
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
          dropDownValue2 == '4-3-3'
              ? const FormationNo1(
            quarterTurn: 2,
          )
              : dropDownValue2 == '3-4-3'
              ? const FormationNo2(quarterTurn: 2)
              : dropDownValue2 == '4-4-2'
              ? const FormationNo3(quarterTurn: 2)
              : const FormationNo4(),
        ],
      ),
    );
  }
}
