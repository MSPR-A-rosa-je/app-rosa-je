import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/user.dart';


class DatabaseService {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      pseudo TEXT,
      age TEXT,
      club TEXT,
      taille TEXT,
      poid TEXT,
      photo TEXT)""");
    await database.execute("""CREATE TABLE runs(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      time REAL,
      calorie REAL,
      distance REAL,
      speed REAL,
      elevation REAL,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)""");
    await database.execute("""CREATE TABLE jumps(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      numberOfJumps INTEGER,
      jumpsPerMinute INTEGER,
      calorieBurn REAL,
      time REAL,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)""");
  }

// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    var path = await sql.getDatabasesPath();
    print(path);
    return sql.openDatabase(
      join(await sql.getDatabasesPath(), 'b3dev.db'),
      version: 3,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
      onUpgrade: (sql.Database database, int oldVersion, int newVersion) async {
        if (oldVersion == 2) {
          await database.execute("ALTER TABLE users ADD pseudo TEXT");
        }
      },
    );
  }


  // Create new user
  static Future<int> createUser(User user) async {
    final db = await DatabaseService.db();
    final id = await db.insert(User.table, user.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all users
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await DatabaseService.db();
    return db.query(User.table, orderBy: "id");
  }

  // Read a single user by id
  static Future<List<Map<String, dynamic>>> getUser(int id) async {
    final db = await DatabaseService.db();
    return db.query(User.table, where: "id = ?", whereArgs: [id], limit: 1);
  }


}
