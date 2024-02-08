import 'package:football_host/data/model/match/match_schedule_model.dart';
import 'package:football_host/data/model/player_model.dart';
import 'package:football_host/data/model/team_model.dart';
import 'package:football_host/view_model/matchViewModel/schedule_view_model.dart';
import 'package:football_host/view_model/player_view_model.dart';
import 'package:football_host/view_model/teamViewModel/team_view_model.dart';
import 'package:football_host/view_model/tournament_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../view_model/matchViewModel/match_view_model.dart';
import '../model/match/match_model.dart';
import '../model/tournament_model.dart';

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
        "pole TEXT)"
    );

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

    await db.execute("CREATE TABLE MATCH(id INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "tournamentId INTEGER NOT NULL,"
        "team1Id INTEGER NOT NULL,"
        "team2Id INTEGER NOT NULL,"
        "team1Name TEXT,"
        "team2Name TEXT,"
        "team1Score INTEGER,"
        "team2Score INTEGER,"
        "penaltyScore INTEGER,"
        "scheduleId INTEGER,"
        "FOREIGN KEY(scheduleId) REFERENCES Schedule(id),"
        "FOREIGN KEY(tournamentId) REFERENCES TOURNAMENT(id) ON DELETE CASCADE,"
        "FOREIGN KEY(team1Id) REFERENCES TEAM(id),"
        "FOREIGN KEY(team2Id) REFERENCES TEAM(id))");
  }

  // Insert Tournaments
  Future<int?> insert(Tournament tournament) async {
    var dbClient = await db;
    return await dbClient?.insert('TOURNAMENT', tournament.toMap());
  }

  // Get Tournaments
  Future<List<Map<String, dynamic>>?> getTournaments() async {
    var dbClient = await db;
    return await dbClient?.query('TOURNAMENT');
  }

  // Get Teams
  Future<List<Team>> getTeams(int tournamentId) async{
    var dbClient = await db;
    final List<Map<String, dynamic>>? maps = await dbClient?.query('TEAM', where: 'tournamentId = ?' , whereArgs: [tournamentId] );
    return List.generate(maps!.length, (index) {
      return Team.fromMap(maps[index]);
    } );
  }


  // Insert Teams
  Future<int?> insertTeams(int tournamentId, Team team) async {
    var dbClient = await db;
    return await dbClient?.insert('TEAM', team.toMap(tournamentId));
  }

  // Insert Players
  Future<int?> insertPlayer(int teamId, Player player) async {
    var dbClient = await db;
    return await dbClient?.insert('PLAYER', player.toMap(teamId));
  }

  // Get Players
  Future<List<Player>> getPlayers(int teamId) async{
    var dbClient = await db;
    final List<Map<String, dynamic>>? maps = await dbClient?.query('PLAYER', where: 'teamId = ?', whereArgs: [teamId]);
    return List.generate(maps!.length, (index) {
      return Player.fromMap(maps[index]);
    });
  }

  // Insert Schedule
  Future<int?> insertSchedule(int tournamentId, Schedule schedule) async {
    var dbClient = await db;
    return dbClient?.insert('Schedule', schedule.toMap(tournamentId));
  }

  // Get Schedule
  Future<List<Schedule>> getSchedule(int tournamentId) async{
    var dbClient = await db;
    final List<Map<String, dynamic>>? maps = await dbClient?.query(
        'Schedule',
        where: 'tournamentId = ? ',
        whereArgs: [tournamentId]);
    return List.generate(maps!.length, (index) {
      return Schedule.fromMap(maps[index]);
    });

  }

  Future<Tournament> insertPoles(Tournament tournament, String poleFormation) async {
    var dbClient = await db;
    try {
      await dbClient!.update('TOURNAMENT', {'pole': poleFormation},
          where: "id = ?", whereArgs: [tournament.id]);
      Tournament updatedTournament = tournament.copyWith(pole: poleFormation);
      return updatedTournament;
    } catch(e) {
      throw Exception('failed to add poles.');
    }

  }

  Future<Matches> insertMatches(int tournamentId, Matches matches) async {
    var dbClient = await db;
    int? id = await dbClient?.insert('MATCH', matches.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (id != null && id > 0) {
      Matches updatedMatch = matches.copyWith(id: id);
      return updatedMatch;
    } else {
      throw Exception('failed to insert match');
    }
  }



  Future getTeamNameById(int teamId) async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.query(
      'TEAM',
      columns: ['teamName'],
      where: 'id = ?',
      whereArgs: [teamId],
    );

    if (result.isNotEmpty) {
      return result.first['teamName'];
    } else {
      return [];
    }
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!
        .delete("TOURNAMENT", where: "id =?", whereArgs: [id]);
  }
}
