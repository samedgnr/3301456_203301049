import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/user_model.dart';

class DbUtils {
  static final DbUtils _dbUtils = DbUtils._internal();

  DbUtils._internal();

  factory DbUtils() {
    return _dbUtils;
  }

  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String path = join(await getDatabasesPath(), 'users_database.db');
    var dbUsers = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbUsers;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, number TEXT, E-mail TEXT, password TEXT)");
  }

  Future<void> deleteTable() async {
    final Database? db = await this.db;
    db?.delete('users');
  }

  Future<void> insertUser(User user) async {
    final Database? db = await this.db;
    await db?.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the users from the users table.
  Future<List<User>> users() async {
    // Get a reference to the database.
    final Database? db = await this.db;
    // Query the table for all The Users.
    final List<Map<String, Object?>>? maps = await db?.query('users');

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps!.length, (i) {
      return User(
        number: maps[i]['number'].toString(),
        name: maps[i]['name'].toString(),
        email: maps[i]['email'].toString(),
        password: maps[i]['password'].toString(),
      );
    });
  }

  Future<void> updateUser(User user) async {
    final db = await this.db;
    await db?.update(
      'users',
      user.toMap(),
      where: "number = ?",
      whereArgs: [user.number],
    );
  }

  Future<void> deleteUser(User user) async {
    final db = await this.db;
    await db?.delete(
      'users',
      where: "number = ?",
      whereArgs: [user.number],
    );
  }
}
