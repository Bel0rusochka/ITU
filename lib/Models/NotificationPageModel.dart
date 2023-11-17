import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Notification{
  int id;
  String title;
  String body;

  Notification({required this.id, required this.title, required this.body});

  factory Notification.fromDb(Map<String, dynamic> dbData){
    return Notification(
      id: dbData['id'] as int,
      title: dbData['title'] as String,
      body: dbData['body'] as String,
    );
  }
}

class NotificationPageModel{

  Future<List<Notification>> loadDBData() async {
    DBProvider dbProvider = DBProvider("NOTIFICATIONS");
    Database database = await dbProvider.database;
    List<Map<String, dynamic>> result = await database.query('NOTIFICATIONS');
    return result.map((row) {
      return Notification.fromDb(row);
    }).toList();
  }

  addNotificationToDb(id, title, body) async{
    DBProvider dbProvider = DBProvider("NOTIFICATIONS");
    dbProvider.addNotificationToDb(id, title, body);
  }

  dellNotificationFromDB(id) async{
    DBProvider dbProvider = DBProvider("NOTIFICATIONS");
    dbProvider.dellNotificationFromDB(id);
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
      await db.execute('CREATE TABLE NOTIFICATIONS (id INTEGER PRIMARY KEY, title TEXT ,' 'body TEXT)');
    });
  }

  addNotificationToDb(id, title, body) async{
    Database db = await database;
    await db.rawInsert(
      "INSERT INTO NOTIFICATIONS (id, title, body) VALUES (?, ?, ?)",
      [id, title, body],
    );
  }

  dellNotificationFromDB(id) async{
    Database db = await database;
    await db.delete('NOTIFICATIONS', where: 'id = ?', whereArgs: [id]);
  }

}