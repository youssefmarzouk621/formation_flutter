import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseFactory {
  Future<void> createCarsTable(Database db) async {
    final createCarsTableQuery = '''CREATE TABLE Cars
    (
      "name" TEXT PRIMARY KEY,
      "brand" TEXT,
      "photo" TEXT,
      "description" TEXT
    )''';

    await db.execute(createCarsTableQuery);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('formation_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print("database init success");
  }

  Future<void> onCreate(Database db, int version) async {
    await createCarsTable(db);
  }
}
