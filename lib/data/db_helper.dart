import 'dart:io';

import 'package:flutter_app_api1/models/product_response.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  static final String dbName = 'products.db';
  static final String tableName = 'products';
  static final String idColumn = 'id';
  static final String productIsFavColumn = 'isFav';
  Database database;
  initDatabase() async {
    database = await createConnection();
  }

  Future<Database> createConnection() async {
    Directory directory = await getApplicationDocumentsDirectory();

    Database database = await openDatabase(join(directory.path, dbName),
        version: 1, onCreate: (db, version) {
          db.execute(
              '''CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $productIsFavColumn INTEGER)''');
        });
    return database;
  }

  // Future<int> createNewTask(TaskModel taskModel) async {
  //   try {
  //     int x = await database.insert(tableName, taskModel.toMap());
  //     return x;
  //   } on Exception catch (e) {
  //     return null;
  //   }
  // }

  Future<List<ProductResponse>> getAllProduct() async {
    try {
      List<Map<String, dynamic>> results = await database.query(tableName);
      List<ProductResponse> products = results.map((e) => ProductResponse.fromJson(e)).toList();
      return products;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<bool> updateProduct(ProductResponse productModel) async {
    try {
      await database.update(tableName, productModel.toJson(),
          where: '$idColumn=?', whereArgs: [productModel.id]);
      return true;
    } on Exception catch (e) {
      return null;
    }
  }

  // deleteTask(TaskModel taskModel) async {
  //   try {
  //     await database
  //         .delete(tableName, where: '$idColumn=?', whereArgs: [taskModel.id]);
  //     return true;
  //   } on Exception catch (e) {
  //     return null;
  //   }
  // }
}
