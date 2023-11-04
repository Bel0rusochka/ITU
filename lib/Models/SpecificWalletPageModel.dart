import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "$dbName.db");
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE INCOME (id INTEGER PRIMARY KEY, name TEXT, amount INTEGER)');
      await db.execute('CREATE TABLE BALANCE (id INTEGER PRIMARY KEY, balance INTEGER)');
    });
  }

  Future<int> _getNextId(String tableName) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT MAX(id) + 1 as id FROM $tableName");
    int id = result.first['id'] ?? 1;
    return id;
  }

  addIncomeToDb(name, amount) async {
    Database db = await database;
    int id = await _getNextId('INCOME');
    await db.rawInsert(
      "INSERT INTO INCOME (id, name, amount) VALUES (?, ?, ?)",
      [id, name, amount],
    );
  }

  deleteIncomeFromDB(id) async {
    Database db = await database;
    await db.delete('INCOME', where: 'id = ?', whereArgs: [id]);
  }

  editIncomeInDB(id, newName, newAmount) async {
    Database db = await database;
    await db.update(
      'INCOME',
      {
        'name': newName,
        'amount': newAmount,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getBalance() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('BALANCE');
    if (result.isNotEmpty) {
      return result.first['balance'] as int;
    } else {
      return 0;
    }
  }

  updateBalance(int newBalance) async {
    Database db = await database;
    await db.rawUpdate('UPDATE BALANCE SET balance = ?', [newBalance]);
  }
}


class Income {
  int id;
  String name;
  int amount;

  Income({required this.id, required this.name, required this.amount});
  factory Income.fromDb(Map<String, dynamic> dbData) {
    return Income(
      id: dbData['id'] as int,
      name: dbData['name'] as String,
      amount: dbData['amount'] as int,
    );
  }
}

class Balance {
  int balance;

  Balance({required this.balance});
}



class IncomePageModel {
  Future<List<Income>> loadDBData() async {
    DBProvider dbProvider = DBProvider("INCOME");
    Database database = await dbProvider.database;
    List<Map<String, dynamic>> result = await database.query('INCOME');
    return result.map((row) {
      return Income.fromDb(row);
    }).toList();
  }

  addIncomeToDb(name, amount) async {
    DBProvider dbProvider = DBProvider("INCOME");
    dbProvider.addIncomeToDb(name, amount);
  }

  deleteIncomeFromDB(id) async {
    DBProvider dbProvider = DBProvider("INCOME");
    dbProvider.deleteIncomeFromDB(id);
  }

  editIncomeInDB(id, newName, newIncome) async {
    DBProvider dbProvider = DBProvider("INCOME");
    dbProvider.editIncomeInDB(id, newName, newIncome);
  }
}

class BalancePageModel {
  Future<int> getBalance() async {
    DBProvider dbProvider = DBProvider("BALANCE");
    return dbProvider.getBalance();
  }

  updateBalance(newBalance) async {
    DBProvider dbProvider = DBProvider("BALANCE");
    dbProvider.updateBalance(newBalance);
  }
}
