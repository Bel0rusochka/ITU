import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Goal{
  int id;
  String name;
  String goalAmount;
  String amount;
  String date;

  Goal({required this.id, required this.name, required this.goalAmount, required this.amount, required this.date});

  factory Goal.fromDb(Map<String, dynamic> dbData){
    return Goal(
      id: dbData['id'] as int,
      name: dbData['name'] as String,
      goalAmount: dbData['goalAmount'] as String,
      amount: dbData['amount'] as String,
      date: dbData['date'] as String,
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

  addGoalToDb(name,  goalAmount, amount,date) async{
    DBProvider dbProvider = DBProvider("GOALS");
    dbProvider.addGoalToDb(name, goalAmount, amount, date);
  }

  dellGoalFromDB(id) async{
    DBProvider dbProvider = DBProvider("GOALS");
    dbProvider.dellGoalFromDB(id);
  }

  editGoalInDB(id, newName,newGoalAmount, newAmount, newDate) async{
    DBProvider dbProvider = DBProvider("GOALS");
    dbProvider.editGoalInDB(id, newName, newGoalAmount, newAmount, newDate);
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
    /*Directory documentsDirectory = await getApplicationSupportDirectory();
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
      await db.execute('CREATE TABLE GOALS (id INTEGER PRIMARY KEY, name TEXT ,' 'goalAmount TEXT, ' 'amount TEXT,  ' 'date TEXT)');
    });
  }

  addGoalToDb(name,goalAmount, amount,date ) async{
    Database db = await database;
    int id = await _getNextIdGoal();
    await db.rawInsert(
      "INSERT INTO GOALS (id, name, goalAmount, amount, date) VALUES (?, ?, ?, ?, ?)",
      [id, name, goalAmount, amount, date],
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

  editGoalInDB(id, newName, newGoalAmount, newAmount, newDate) async {
    Database db = await database;
    await db.update(
      'GOALS',
      {
        'name': newName,
        'goalAmount':newGoalAmount,
        'amount': newAmount,
        'date': newDate,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}