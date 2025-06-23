import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'gradeup.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Users table
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            email TEXT,
            name TEXT,
            student_class TEXT,
            phone_number TEXT,
            payment_status TEXT,
            subjects TEXT
          )
        ''');

        // Quiz table
        await db.execute('''
          CREATE TABLE Quiz (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            quizName TEXT UNIQUE,
            duration INTEGER,
            category TEXT
          )
        ''');

        // Question table
        await db.execute('''
          CREATE TABLE Question (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            quizName TEXT,
            question TEXT,
            correctAnswer TEXT,
            incorrectAnswers TEXT,
            explanation TEXT,
            FOREIGN KEY (quizName) REFERENCES Quiz(quizName) ON DELETE CASCADE
          )
        ''');
      },
    );
  }
}
