import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expense_manager.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            amount REAL NOT NULL,
            category TEXT NOT NULL,
            date TEXT NOT NULL
          )
        ''');

        await db.insert('expenses', {
          'title': 'Ăn uống',
          'amount': 150000.0,
          'category': 'Sinh hoạt',
          'date': '29/10/2026',
        });
        await db.insert('expenses', {
          'title': 'Di chuyển',
          'amount': 50000.0,
          'category': 'Đi lại',
          'date': '28/10/2026',
        });
        await db.insert('expenses', {
          'title': 'Mua sách',
          'amount': 200000.0,
          'category': 'Học tập',
          'date': '27/10/2026',
        });
        await db.insert('expenses', {
          'title': 'Mua sắm',
          'amount': 1500000.0,
          'category': 'Sinh hoạt',
          'date': '25/10/2026',
        });
        await db.insert('expenses', {
          'title': 'Khám bệnh',
          'amount': 3550000.0,
          'category': 'Sức khỏe',
          'date': '22/10/2026',
        });
      },
    );
  }
}
