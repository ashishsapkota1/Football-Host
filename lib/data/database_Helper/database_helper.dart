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

import '../model/tournament_model.dart';

class DbHelper {
  static Database? _db;
  static const String dbName = 'tournament_host.db';
  final TournamentViewModel _tournamentViewModel = TournamentViewModel();
  final TeamViewModel _teamViewModel = TeamViewModel();
  final PlayerViewModel _playerViewModel = PlayerViewModel();
  final ScheduleViewModel scheduleViewModel = ScheduleViewModel();

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
        " name TEXT NOT NULL)");

    await db.execute("CREATE TABLE TEAM(id INTEGER PRIMARY KEY AUTOINCREMENT ,"
        " teamName TEXT NOT NULL, "
        "tournamentId INTEGER NOT NULL,"
        "FOREIGN KEY(tournamentId) REFERENCES TOURNAMENT(id) ON DELETE CASCADE)");

    await db.execute(
        "CREATE TABLE Schedule(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "tournamentId INTEGER NOT NULL,"
        "team1Id INTEGER NOT NULL,"
        "team2Id INTEGER NOT NULL,"
        "team1Name TEXT,"
        "team2Name TEXT,"
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
        "team1Score INTEGER,"
        "team2Score INTEGER,"
        "penaltyScore INTEGER,"
        "FOREIGN KEY(tournamentId) REFERENCES TOURNAMENT(id) ON DELETE CASCADE,"
        "FOREIGN KEY(team1Id) REFERENCES TEAM(id),"
        "FOREIGN KEY(team2Id) REFERENCES TEAM(id))");
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

  Future<MatchSchedule> insertSchedule(int tournamentId, int team1Id,
      int team2Id,String team1Name , String team2Name, MatchSchedule schedule) async {
    var dbClient = await db;
    int? id = await dbClient?.insert(
        'Schedule', schedule.toMap(tournamentId, team1Id, team2Id));
    if (id != null && id > 0) {
      MatchSchedule updatedSchedule = schedule.copyWith(id: id);
      scheduleViewModel.addSchedule(
          tournamentId, team1Id, team2Id,team1Name,team2Name, updatedSchedule);
      return updatedSchedule;
    } else {
      throw Exception('failed to insert schedule');
    }
  }

  Future<Player> insertPlayer(int teamId, Player player) async {
    var dbClient = await db;
    int? id = await dbClient?.insert('PLAYER', player.toMap(teamId));

    if (id != null && id > 0) {
      Player updatedPlayer = player.copyWith(id: id);
      _playerViewModel.addPlayer(teamId, updatedPlayer);
      return updatedPlayer;
    } else {
      throw Exception('cant add player');
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
