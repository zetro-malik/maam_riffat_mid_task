import 'dart:convert';
import 'dart:io';

import 'package:maam_riffat_mid_task/model/product.dart';
import 'package:maam_riffat_mid_task/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
//SINGLETON

  //for initializing instace of this class
  DatabaseHelper._pc();

  //static instance to use
  static DatabaseHelper instance = DatabaseHelper._pc();

//DATABASE

  //reference variable of database...
  static Database? _database;

  //initialize or get database from file
  Future<Database> initializeDatabase() async {
    String dbpath = await getDatabasesPath();
    dbpath = dbpath + "/mid_task1.db";
    var database = await openDatabase(dbpath, version: 1, onCreate: _createdb);
    return database;
  }

  //if initializing then create table for database
  void _createdb(Database db, int newversion) {
    // creations of tables
    String query = '''create table user
                    (
                      ID INTEGER PRIMARY KEY AUTOINCREMENT,
                      username TEXT,
                      password TEXT,
                      image TEXT
                       ) 
                    ''';
    db.execute(query);
  }

//for initializing instace of this class
  Future<Database> get database async {
    // if(_database==null)
    //     _database=await initializeDatabase();
    _database ??= await initializeDatabase();

    return _database!;
  }

  //users

  //insert

  Future<int> insertUser(User obj) async {
    Database db = await instance.database;


    int status = await db.insert("user", obj.toMap());

    return status;
  }

  //update

  Future<int> UpdateUser(User obj) async {

    Database db = await instance.database;
    
    int id = await db.update("user", obj.toMap(),
        where: 'id=? and username=?', whereArgs: [obj.ID, obj.username]);

    return id;
  }

  //delete
  File? image1;
  Future<int> DeleteUser(User obj) async {
    Database db = await instance.database;
    int id = await db.rawDelete("delete from user where id=${obj.ID}");
    return id;
  }

  //read

  Future<bool> checkUser(String username, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query("user", where: 'username=? and password=?',whereArgs: [username,password]);
    
    if(data.isEmpty)
    return true;
    
    return false ;
  }
}
