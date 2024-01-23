import 'package:flutter/material.dart';
import 'package:football_host/resources/utils/routes/routes.dart';
import 'package:football_host/resources/utils/routes/routes_name.dart';
import 'package:football_host/view_model/home_view_model.dart';
import 'package:football_host/view_model/navbar_view_model.dart';
import 'package:football_host/view_model/player_view_model.dart';
import 'package:football_host/view_model/teamViewModel/teamName_view_model.dart';
import 'package:football_host/view_model/teamViewModel/team_view_model.dart';
import 'package:football_host/view_model/tournamentName_view_model.dart';
import 'package:football_host/view_model/tournament_view_model.dart';
import 'package:provider/provider.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TournamentViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) =>TournamentNameViewModel()),
        ChangeNotifierProvider(create: (context) => NavbarViewModel()),
        ChangeNotifierProvider(create: (context) => TeamViewModel()),
        ChangeNotifierProvider(create: (context) => PlayerViewModel()),
        ChangeNotifierProvider(create: (context) => TeamNameViewModel())
      ],
      child:  MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.homePage,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
