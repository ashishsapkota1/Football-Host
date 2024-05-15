import 'package:football_host/view_model/matchViewModel/schedule_view_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../view_model/matchViewModel/match_view_model.dart';

class DbHelper {
  static Database? _db;
  static const String dbName = 'tournament_host.db';
  final ScheduleViewModel scheduleViewModel = ScheduleViewModel();
  final MatchViewModel matchViewModel = MatchViewModel();

  DbHelper._();

  static final DbHelper instance = DbHelper._();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var databasePath = await getApplicationDocumentsDirectory();
    String path = join(databasePath.path, dbName);
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  _createDb(Database db, int version) async {
    await db.execute("CREATE TABLE TOURNAMENT("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        " name TEXT NOT NULL,"
        "pole TEXT)");

    await db.execute("CREATE TABLE TEAM(id INTEGER PRIMARY KEY AUTOINCREMENT ,"
        " teamName TEXT NOT NULL, "
        "tournamentId INTEGER NOT NULL,"
        "FOREIGN KEY(tournamentId) REFERENCES TOURNAMENT(id) ON DELETE CASCADE)");

    await db.execute(
        "CREATE TABLE Schedule(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "tournamentId INTEGER NOT NULL,"
        "team1Id INTEGER,"
        "team2Id INTEGER,"
        "team1Name TEXT,"
        "team2Name TEXT,"
        "team1DependsOn INTEGER,"
        "team2DependsOn INTEGER,"
        "matchNumber INTEGER,"
        "roundNumber INTEGER,"
        "roundName TEXT,"
        "FOREIGN KEY(tournamentId) REFERENCES TOURNAMENT(id) ON DELETE CASCADE,"
        "FOREIGN KEY(team1Id) REFERENCES TEAM(id),"
        "FOREIGN KEY(team2Id) REFERENCES TEAM(id))");

    await db
        .execute("CREATE TABLE PLAYER(id INTEGER PRIMARY KEY AUTOINCREMENT ,"
            "playerName TEXT NOT NULL, "
            "position TEXT NOT NULL, "
            "jerseyNo INTEGER, "
            "teamId INTEGER NOT NULL,"
            "FOREIGN KEY(teamId) REFERENCES TEAM(id) ON DELETE CASCADE)");

    await db.execute("CREATE TABLE MATCH("
        "id INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "tournamentId INTEGER,"
        "team1Id INTEGER,"
        "team2Id INTEGER,"
        "team1Name TEXT,"
        "team2Name TEXT,"
        "team1Score INTEGER,"
        "team2Score INTEGER,"
        "isFirstHalf INTEGER,"
        "isSecondHalf INTEGER,"
        "hasStarted INTEGER,"
        "penaltyScore INTEGER,"
        "matchTime INTEGER,"
        "scheduleId INTEGER,"
        "FOREIGN KEY(scheduleId) REFERENCES Schedule(id),"
        "FOREIGN KEY(tournamentId) REFERENCES TOURNAMENT(id) ON DELETE CASCADE,"
        "FOREIGN KEY(team1Id) REFERENCES TEAM(id),"
        "FOREIGN KEY(team2Id) REFERENCES TEAM(id))");

    await db.execute(
        "CREATE TABLE GOALSCORER(id INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "matchId INTEGER,"
        "teamId INTEGER,"
        "scorerId INTEGER,"
        "goalTime INTEGER,"
        "FOREIGN KEY(matchId) REFERENCES MATCH(id),"
        "FOREIGN KEY(teamId) REFERENCES TEAM(id),"
        "FOREIGN KEY(scorerId) REFERENCES PLAYER(id))");
  }
}
