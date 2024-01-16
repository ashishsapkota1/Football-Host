import 'package:flutter/material.dart';
import 'package:football_host/view/home_view.dart';
import 'package:football_host/view_model/tournament_view_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'model/player_model.dart';
import 'model/teams_model.dart';
import 'model/tournament_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  await Hive.openBox<Tournament>('tournaments');
  await Hive.openBox<TeamName>('teams');
  await Hive.openBox<Player>('players');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TournamentViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    );
  }
}
