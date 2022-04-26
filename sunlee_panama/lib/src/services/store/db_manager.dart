import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class DataBaseManager {
  static bool isInDebugMode = false;
  static String _dbName = "sunlee.db";
  static int _version = 2;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  final String _tableName;
  late Database _db;
  final List<Map<String, dynamic>> schema;

  DataBaseManager(
    this._tableName,
    this.schema,
  ) {}

  Future<void> _initDb() async {
    final dbFolder = await getDatabasesPath();
    if (!await Directory(dbFolder).exists()) {
      await Directory(dbFolder).create(recursive: true);
    }
    final dbPath = join(dbFolder, _dbName);
    if (isInDebugMode) {
      // delete existing if any
      await deleteDatabase(dbPath);
    }

    _db = await openDatabase(
      dbPath,
      version: _version,
      readOnly: false,
      onCreate: (db, version) async {
        // call database script that is saved in a file in assets
        String script = await rootBundle
            .loadString("assets/data/db_version_${version}.sql");
        List<String> scripts = script.split(";");
        scripts.forEach((v) {
          if (v.isNotEmpty) {
            print(v.trim());
            db.execute(v.trim());
          }
        });
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // call database script that is saved in a file in assets
        String script = await rootBundle
            .loadString("assets/data/db_version_${newVersion}.sql");
        List<String> scripts = script.split(";");
        scripts.forEach((v) {
          if (v.isNotEmpty) {
            print(v.trim());
            db.execute(v.trim());
          }
        });
      },
    );
  }

  Future<bool> asyncInit() async {
    await _memoizer.runOnce(() async {
      await _initDb();
    });
    return true;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    await asyncInit();
    final List<Map<String, dynamic>> jsons =
        await _db.rawQuery('SELECT * FROM $_tableName');
    print('${jsons.length} rows retrieved from db!');
    return jsons;
  }

  Future<List<Map<String, dynamic>>> getUnique(int id) async {
    await asyncInit();
    final List<Map<String, dynamic>> jsons =
        await _db.rawQuery('SELECT * FROM $_tableName  WHERE id = "${id}"');
    return jsons;
  }

  Future<List<Map<String, dynamic>>> getWhere(String field, dynamic id) async {
    await asyncInit();
    final List<Map<String, dynamic>> jsons = await _db
        .rawQuery('SELECT * FROM $_tableName  WHERE ${field} = "${id}"');
    return jsons;
  }

  Future<int> addItem(Map<String, dynamic> item) async {
    await asyncInit();
    int idInsert = 0;
    final id = item['id'] ?? Uuid().v4();
    String fields = "id";
    for (var varItem in schema) {
      fields += ", ${varItem['name']}";
    }
    String values = 'null';
    for (var varItem in schema) {
      String fd = varItem['name'];
      values += ', "${item[fd]}"';
    }
    await _db.transaction(
      (Transaction txn) async {
        idInsert = await txn.rawInsert(
          '''
          INSERT INTO $_tableName
            ($fields)
          VALUES
            (
              $values
            )''',
        );
        print('Inserted todo item with id=$idInsert.');
      },
    );
    return idInsert;
  }

  Future<void> modItem(
      String field, int idItem, Map<String, dynamic> item) async {
    await asyncInit();
    await _db.transaction(
      (Transaction txn) async {
        final int id = await txn
            .update(_tableName, item, where: '$field = ?', whereArgs: [idItem]);
      },
    );
  }

  Future<void> deleteItem(int id) async {
    await asyncInit();
    await _db.transaction(
      (Transaction txn) async {
        final int count =
            await txn.rawDelete('DELETE FROM ${_tableName} WHERE id =?', [id]);
        print(
            'Remove FROM ${_tableName} item with id=$id. Affected $count rows.');
      },
    );
  }

  Future<void> deleteAll(String field, dynamic arg) async {
    await asyncInit();
    await _db.transaction(
      (Transaction txn) async {
        final int count = await txn
            .rawDelete('DELETE FROM ${_tableName} WHERE ${field} =?', [arg]);
        print('Remove FROM ${_tableName} item. Affected $count rows.');
      },
    );
  }
}
