import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Expense {
  int id;
  String name;
  int amount;
  int color;
  IconData icon;

  Expense({
    required this.name,
    required this.amount,
    required this.id,
    required this.color,
    required this.icon,
  });

  factory Expense.fromDb(Map<String, dynamic> dbData) {
    return Expense(
      id: dbData['id'] as int,
      name: dbData['name'] as String,
      amount: dbData['amount'] as int,
      color: dbData['color'] as int,
      icon: IconData(dbData['icon'] as int),
    );
  }
}

class ExpensePageModel {
  Future<List<Expense>> loadDBData() async {
    DBProvider dbProvider = DBProvider("EXPENSE");
    Database database = await dbProvider.database;
    List<Map<String, dynamic>> result = await database.query('EXPENSE');
    return result.map((row) {
      return Expense.fromDb(row);
    }).toList();
  }
  Future<Expense> getExpenseById(int id) async {
    DBProvider dbProvider = DBProvider("EXPENSE");
    Database database = await dbProvider.database;
    List<Map<String, dynamic>> result = await database.query(
      'EXPENSE',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Expense.fromDb(result.first);
    } else {
      throw Exception('Expense not found');
    }
  }

  addExpenseToDb(String name, int amount, int color, IconData icon) async {
    DBProvider dbProvider = DBProvider("EXPENSE");
    await dbProvider.addExpenseToDb(name, amount, color, icon.codePoint);
  }

  deleteExpenseFromDB(id) async {
    DBProvider dbProvider = DBProvider("EXPENSE");
    dbProvider.deleteExpenseFromDB(id);
  }

  editExpenseInDB(id, String newName, int newAmount, int newColor, IconData newIcon) async {
    DBProvider dbProvider = DBProvider("EXPENSE");
    dbProvider.editExpenseInDB(id, newName, newAmount, newColor, newIcon.codePoint);
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
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE EXPENSE (id INTEGER PRIMARY KEY, name TEXT, amount INTEGER, color INTEGER, icon INTEGER)',
      );
    });
  }

  addExpenseToDb(name, amount, color, icon) async {
    Database db = await database;
    int id = await _getNextId('EXPENSE');
    await db.rawInsert(
      "INSERT INTO EXPENSE (id, name, amount, color, icon) VALUES (?, ?, ?, ?, ?)",
      [id, name, amount, color, icon],
    );
  }

  Future<int> _getNextId(String tableName) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.rawQuery("SELECT MAX(id) + 1 as id FROM $tableName");
    int id = result.first['id'] ?? 1;
    return id;
  }

  deleteExpenseFromDB(id) async {
    Database db = await database;
    await db.delete('EXPENSE', where: 'id = ?', whereArgs: [id]);
  }

  editExpenseInDB(id, newName, newAmount, newColor, newIcon) async {
    Database db = await database;
    await db.update(
      'EXPENSE',
      {
        'name': newName,
        'amount': newAmount,
        'color': newColor,
        'icon': newIcon
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
