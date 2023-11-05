import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Goal{
  int id;
  String name;
  String date;
  String amount;
  String goalAmount;

  Goal({required this.id, required this.name, required this.date, required this.amount, required this.goalAmount});

  factory Goal.fromDb(Map<String, dynamic> dbData){
    return Goal(
      id: dbData['id'] as int,
      name: dbData['name'] as String,
      date: dbData['date'] as String,
      amount: dbData['amount'] as String,
      goalAmount: dbData['goalAmount'] as String,
    );
  }
}

class GoalsPageModel{

  Future<List<Goal>> loadDBData() async {
    DBProvider dbProvider = DBProvider("GOALS");
    Database database = await dbProvider.database;
    List<Map<String, dynamic>> result = await database.query('GOALS');
    return result.map((row) {
      return Goal.fromDb(row);
    }).toList();
  }

  addGoalToDb(name, date, amount, goalAmount) async{
    DBProvider dbProvider = DBProvider("GOALS");
    dbProvider.addGoalToDb(name, date, amount, goalAmount);
  }

  dellGoalFromDB(id) async{
    DBProvider dbProvider = DBProvider("GOALS");
    dbProvider.dellGoalFromDB(id);
  }

  editGoalInDB(id, newName, newAmount, newDate, newGoalAmount) async{
    DBProvider dbProvider = DBProvider("GOALS");
    dbProvider.editGoalInDB(id, newName, newAmount, newDate, newGoalAmount);
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
   /*  Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "$dbName.db");
    await deleteDatabase(path);*/
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "$dbName.db");
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE GOALS (id INTEGER PRIMARY KEY, name TEXT ,' 'date TEXT, ' 'amount TEXT, ' 'goalAmount TEXT)');
    });
  }

  addGoalToDb(name, date, amount, goalAmount) async{
    Database db = await database;
    int id = await _getNextIdGoal();
    await db.rawInsert(
      "INSERT INTO GOALS (id, name, date, amount, goalAmount) VALUES (?, ?, ?, ?, ?)",
      [id, name, date, amount, goalAmount],
    );
  }

  Future<int> _getNextIdGoal() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT MAX(id) + 1 as id FROM GOALS");
    int id = result.first['id'] ?? 1;
    return id;
  }

  dellGoalFromDB(id) async{
    Database db = await database;
    await db.delete('GOALS', where: 'id = ?', whereArgs: [id]);
  }

  editGoalInDB(id, newName, newAmount, newDate, newGoalAmount) async {
    Database db = await database;
    await db.update(
      'GOALS',
      {
        'name': newName,
        'amount': newAmount,
        'date': newDate,
        'goalAmount':newGoalAmount,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}