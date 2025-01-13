import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer' as dev;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    try {
      dev.log('DatabaseHelper: Getting database instance');
      if (_database != null) {
        dev.log('DatabaseHelper: Returning existing database instance');
        return _database!;
      }
      _database = await _initDB('subscriptions.db');
      dev.log('DatabaseHelper: New database instance created');
      return _database!;
    } catch (e, stackTrace) {
      dev.log(
        'DatabaseHelper: Error getting database',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Database> _initDB(String filePath) async {
    try {
      dev.log('DatabaseHelper: Initializing database');
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);
      
      dev.log('DatabaseHelper: Database path: $path');

      return await openDatabase(
        path,
        version: 1,
        onCreate: _createDB,
      );
    } catch (e, stackTrace) {
      dev.log(
        'DatabaseHelper: Error initializing database',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> _createDB(Database db, int version) async {
    try {
      dev.log('DatabaseHelper: Creating database tables');
      
      await db.execute('''
        CREATE TABLE subscriptions(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          app_name TEXT NOT NULL,
          amount REAL NOT NULL,
          period TEXT NOT NULL,
          start_date TEXT NOT NULL,
          auto_renewal INTEGER NOT NULL
        )
      ''');
      
      dev.log('DatabaseHelper: Database tables created successfully');
    } catch (e, stackTrace) {
      dev.log(
        'DatabaseHelper: Error creating database tables',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}