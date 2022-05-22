import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DbManager {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        details TEXT,
        isComplete TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

//initialize db
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'todosdb.db',
      version: 2,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
    );
  }

//create todo
  static Future<int> createTodo(
      {required String title, String? details, String? isComplete}) async {
    final db = await DbManager.db();

    final data = {'title': title, 'details': details, "isComplete": isComplete};
    final id = await db.insert('todos', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // all todo list
  static Future<List<Map<String, dynamic>>> getTodoList() async {
    final db = await DbManager.db();
    return db.query('todos', orderBy: "id");
  }

  // Update todo
  static Future<int> updateTodo(
      int id, String title, String? details, String? isComplete) async {
    final db = await DbManager.db();

    final data = {
      'title': title,
      'details': details,
      "isComplete": isComplete,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('todos', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete todo
  static Future<void> deleteTodo(int id) async {
    final db = await DbManager.db();
    try {
      await db.delete("todos", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
