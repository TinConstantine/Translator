import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/translator.dart';
import '../global.dart';

class DatabaseHelper {
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);
    Database database = await openDatabase(path, version: 1);
    return database;
  }

  Future<void> createTable(Database database,
      {required String tableName}) async {
    await database.execute(
        ' CREATE TABLE IF NOT EXISTS $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, originalLang TEXT, translatorLang TEXT, originalWord TEXT, translatorWord TEXT)');
  }

  Future<void> insertData(Database database,
      {String? originalLang,
      String? translatorLang,
      String? originalWord,
      String? translatorWord,
      required String tableName}) async {
    await database.insert(tableName, {
      'originalLang': originalLang,
      'translatorLang': translatorLang,
      'originalWord': originalWord,
      'translatorWord': translatorWord
    });
  }

  Future<List<Translator>> getData(Database database,
      {required String tableName}) async {
    final data = await database.query(tableName);
    return data.map((e) => Translator.fromJson(e)).toList();
  }

  Future<void> deletaAllData(Database database,
      {required String tableName}) async {
    await database.delete(tableName);
  }

  Future<bool> checkExist(Database database,
      {required String tableName, required String originalWord}) async {
    final data = await database
        .query(tableName, where: 'originalWord = ?', whereArgs: [originalWord]);
    return data.isNotEmpty;
  }

  Future<void> deleteAItem(Database database,
      {String originalWord = "", required String tableName}) async {
    await database.delete(tableName,
        where: 'originalWord = ?', whereArgs: [originalWord]);
  }
}
