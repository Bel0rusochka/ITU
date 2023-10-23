import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Debt{
  int id;
  String name;
  String date;
  String amount;

  Debt({required this.id, required this.name, required this.date, required this.amount});

  factory Debt.fromDb(Map<String, dynamic> dbData){
    return Debt(
      id: dbData['id'] as int,
      name: dbData['name'] as String,
      date: dbData['date'] as String,
      amount: dbData['amount'] as String,
    );
  }
}

class DebtPageModel{

  Future<List<Debt>> loadDBData() async {
    DBProvider dbProvider = DBProvider("DEBTS");
    Database database = await dbProvider.database;
    List<Map<String, dynamic>> result = await database.query('DEBTS');
    return result.map((row) {
      return Debt.fromDb(row);
    }).toList();
  }

  addDebtToDb(name, date, amount) async{
    DBProvider dbProvider = DBProvider("DEBTS");
    dbProvider.addDebtToDb(name, date, amount);
  }
}

class DBProvider {
  final String dbName;
  static final Map<String, DBProvider> _instances = {};

  DBProvider._internal(this.dbName);

  factory DBProvider(String dbName) {
    if (_instances.containsKey(dbName)) {
      return _instances[dbName]!;
    } else {
      final instance = DBProvider._internal(dbName);
      _instances[dbName] = instance;
      return instance;
    }
  }

  Database? _database;

  Future<Database> get database async {
    // Directory documentsDirectory = await getApplicationSupportDirectory();
    // String path = join(documentsDirectory.path, "$dbName.db");
    // await deleteDatabase(path);
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "$dbName.db");
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE DEBTS (id INTEGER PRIMARY KEY, name TEXT ,' 'date TEXT, ' 'amount TEXT)');
    });
  }

  addDebtToDb(name, date, amount) async{
    Database db = await database;
    int id = await _getNextId();
    await db.rawInsert(
        "INSERT INTO DEBTS (id, name, date, amount) VALUES (?, ?, ?, ?)",
      [id, name, date, amount],
    );
  }

  Future<int> _getNextId() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT MAX(id) + 1 as id FROM DEBTS");
    int id = result.first['id'] ?? 1;
    return id;
  }
}