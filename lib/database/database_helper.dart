import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/term_model.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await _initDB('saved_words.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {

    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {

    await db.execute('''
    CREATE TABLE saved_words(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      subject TEXT,
      english TEXT,
      kannada TEXT,
      explanation TEXT
    )
    ''');
  }

  Future<int> insertWord(TermModel term) async {

    final db = await instance.database;

    return await db.insert(
      'saved_words',
      term.toMap(),
    );
  }

  Future<List<TermModel>> getSavedWords() async {

    final db = await instance.database;

    final result = await db.query('saved_words');

    return result.map((e) => TermModel.fromMap(e)).toList();
  }

  Future<int> deleteWord(int id) async {

    final db = await instance.database;

    return await db.delete(
      'saved_words',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}