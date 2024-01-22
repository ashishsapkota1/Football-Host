import 'package:football_host/data/model/team_model.dart';
import 'package:football_host/view_model/team_view_model.dart';
import 'package:football_host/view_model/tournament_view_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/tournament_model.dart';

class DbHelper {
  static Database? _db;
  static const String dbName = 'tournament_host.db';
  final TournamentViewModel _tournamentViewModel = TournamentViewModel();
  final TeamViewModel _teamViewModel = TeamViewModel();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return null;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), dbName);
    var db = await openDatabase(path, version: 3, onCreate: _createDb);
    return db;
  }

  _createDb(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS TOURNAMENT("
        "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        " name TEXT NOT NULL)");

    await db.execute(
        "CREATE TABLE IF NOT EXISTS TEAM(ID INTEGER PRIMARY KEY AUTOINCREMENT ,"
        " teamName TEXT NOT NULL, "
        "tournamentId INTEGER NOT NULL,"
        "FOREIGN KEY(tournamentId) REFERENCES TOURNAMENT(ID) ON DELETE CASCADE)");
  }

  Future<Tournament> insert(Tournament tournament) async {
    var dbClient = await db;
    int? id = await dbClient?.insert('TOURNAMENT', tournament.toMap());

    if (id != null && id > 0) {
      Tournament updatedTournament = tournament.copyWith(id: id);

      _tournamentViewModel.addTournament(updatedTournament);

      return updatedTournament;
    } else {
      throw Exception('Failed to insert tournament');
    }
  }

  Future<Team> insertTeams(int tournamentId, Team team) async {
    var dbClient = await db;
    int? id = await dbClient?.insert('TEAM', team.toMap(tournamentId));
    if (id != null && id > 0) {
      Team updatedTeam = team.copyWith(id: id);
      _teamViewModel.addTeam(tournamentId, updatedTeam);
      return updatedTeam;
    } else {
      throw Exception('failed to insert teams');
    }
  }


  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!
        .delete("TOURNAMENT", where: "id =?", whereArgs: [id]);
  }
}
