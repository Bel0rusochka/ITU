import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Balance{
  int id;
  String name;
  String amount;

  Balance({required this.id, required this.name, required this.amount});

  factory Balance.fromDb(Map<String, dynamic> dbData){
    return Balance(
      id: dbData['id'] as int,
      name: dbData['name'] as String,
      amount: dbData['amount'] as String,
    );
  }
}

class BalancePageModel{

  Future<List<Balance>> loadDBData() async {
    DBProvider dbProvider = DBProvider("BALANCE");
    Database database = await dbProvider.database;
    List<Map<String, dynamic>> result = await database.query('BALANCE');
    return result.map((row) {
      return Balance.fromDb(row);
    }).toList();
  }

  addBalanceToDb(name, amount) async{
    DBProvider dbProvider = DBProvider("BALANCE");
    dbProvider.addBalanceToDb(name, amount);
  }

  dellBalanceFromDB(id) async{
    DBProvider dbProvider = DBProvider("BALANCE");
    dbProvider.dellBalanceFromDB(id);
  }

  editBalanceInDB(id, newName, newAmount) async{
    DBProvider dbProvider = DBProvider("BALANCE");
    dbProvider.editBalanceInDB(id, newName, newAmount);
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
      await db.execute('CREATE TABLE BALANCE (id INTEGER PRIMARY KEY, name TEXT , ' 'amount TEXT)');
    });
  }

  addBalanceToDb(name,amount) async{
    Database db = await database;
    int id = await _getNextIdBalance();
    await db.rawInsert(
      "INSERT INTO BALANCE (id, name, amount) VALUES (?, ?, ?)",
      [id, name, amount],
    );
  }

  Future<int> _getNextIdBalance() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT MAX(id) + 1 as id FROM BALANCE");
    int id = result.first['id'] ?? 1;
    return id;
  }

  dellBalanceFromDB(id) async{
    Database db = await database;
    await db.delete('BALANCE', where: 'id = ?', whereArgs: [id]);
  }

  editBalanceInDB(id, newName, newAmount) async {
    Database db = await database;
    await db.update(
      'BALANCE',
      {
        'name': newName,
        'amount': newAmount,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}