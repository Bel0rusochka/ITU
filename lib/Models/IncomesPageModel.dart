import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Income {
  int id;
  int walletId;
  String name;
  int amount;
  int color;
  IconData icon;
  DateTime creationDate;

  Income({
    required this.walletId,
    required this.name,
    required this.amount,
    required this.id,
    required this.color,
    required this.icon,
    required this.creationDate,
  });

  factory Income.fromDb(Map<String, dynamic> dbData) {
    return Income(
      id: dbData['id'] as int,
      walletId: dbData['walletId'] as int,
      name: dbData['name'] as String,
      amount: dbData['amount'] as int,
      color: dbData['color'] as int,
      icon: IconData(dbData['icon'] as int),
      creationDate: DateTime.parse(dbData['creationDate'] as String),
    );
  }
}

class IncomesPageModel {
  Future<List<Income>> loadDBData() async {
    DBProvider dbProvider = DBProvider("Income");
    Database database = await dbProvider.database;
    List<Map<String, dynamic>> result = await database.query('Income');
    return result.map((row) {
      return Income.fromDb(row);
    }).toList();
  }
  Future<Income> getIncomeById(int id) async {
    DBProvider dbProvider = DBProvider("Income");
    Database database = await dbProvider.database;
    List<Map<String, dynamic>> result = await database.query(
      'Income',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Income.fromDb(result.first);
    } else {
      throw Exception('Income not found');
    }
  }

  addIncomeToDb(int walletId, String name, int amount, int color, IconData icon, DateTime creationDate) async {
    DBProvider dbProvider = DBProvider("Income");
    await dbProvider.addIncomeToDb(walletId, name, amount, color, icon.codePoint, creationDate);
  }

  deleteIncomeFromDB(id) async {
    DBProvider dbProvider = DBProvider("Income");
    dbProvider.deleteIncomeFromDB(id);
  }

  editIncomeInDB(id, String newName, int newAmount, int newColor, IconData newIcon) async {
    DBProvider dbProvider = DBProvider("Income");
    dbProvider.editIncomeInDB(id, newName, newAmount, newColor, newIcon.codePoint);
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
            'CREATE TABLE Income (id INTEGER PRIMARY KEY, walletId INTEGER, name TEXT, amount INTEGER, color INTEGER, icon INTEGER, creationDate TEXT)',
          );
        });
  }

  addIncomeToDb(walletId, name, amount, color, icon, creationDate) async {
    Database db = await database;
    int id = await _getNextId('Income');
    await db.rawInsert(
      "INSERT INTO Income (id, walletId, name, amount, color, icon,creationDate) VALUES (?, ?, ?, ?, ?, ?,?)",
      [id, walletId, name, amount, color, icon, creationDate.toIso8601String()],
    );
  }

  Future<int> _getNextId(String tableName) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
    await db.rawQuery("SELECT MAX(id) + 1 as id FROM $tableName");
    int id = result.first['id'] ?? 1;
    return id;
  }

  deleteIncomeFromDB(id) async {
    Database db = await database;
    await db.delete('Income', where: 'id = ?', whereArgs: [id]);
  }

  editIncomeInDB(id, newName, newAmount, newColor, newIcon) async {
    Database db = await database;
    await db.update(
      'Income',
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
