import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TournamentRepository {
  static const String _databaseName = 'tournament.db';
  static const String _tournamentTable = 'tournaments';
  static const String _teamTable = 'teams';
  static const String _playerTable = 'players';

  late Database _database;

  Future<void> initializeDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tournamentTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE $_teamTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tournament_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            FOREIGN KEY (tournament_id) REFERENCES $_tournamentTable (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE $_playerTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            team_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            position TEXT NOT NULL,
            jerseyNo INTEGER NOT NULL,
            FOREIGN KEY (team_id) REFERENCES $_teamTable (id)
          )
        ''');
      },
    );
  }
}
