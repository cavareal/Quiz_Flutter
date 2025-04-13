import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/party_question.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'questions.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE questions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            text TEXT
          )
        ''');
      },
    );
  }

  Future<List<PartyQuestion>> getQuestions() async {
    final database = await db;
    final result = await database.query('questions');
    return result.map((e) => PartyQuestion.fromMap(e)).toList();
  }

  Future<void> insertQuestion(PartyQuestion question) async {
    final database = await db;
    await database.insert('questions', question.toMap());
  }

  Future<void> deleteQuestion(int id) async {
    final database = await db;
    await database.delete('questions', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateQuestion(PartyQuestion question) async {
    final database = await db;
    await database.update('questions', question.toMap(), where: 'id = ?', whereArgs: [question.id]);
  }
}
