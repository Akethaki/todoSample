
//import 'dart:convert';
//import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
//import 'dart:io' as io;
//import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:todo_my/model/note.dart';


class DBHelper{

  static final DBHelper instance = DBHelper._init();

  static Database? _database;
  //static const String DB_NAME = 'tdnote.db';
  DBHelper._init();

  // static const String ID = 'id';
  // static const String TITLE = 'title';
  // static const String TASK = 'task';

  //static const String TABLE = 'Category';

  

  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    // io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, filePath);

    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);

    return await openDatabase(path, version: 1, onCreate: _creatDB);
  }


  // _initDB() async{
  //   io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, DB_NAME);
  //   var db = await openDatabase(path, version: 1,onCreate: _onCreate);
  //   return db;
  // }

  Future _creatDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEYAUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';


    await db.execute('''
CREATE TABLE $tableNotes (
  ${NoteFields.id} $idType,
  ${NoteFields.isImportant} $boolType,
  ${NoteFields.number} $integerType,
  ${NoteFields.title} $textType,
  ${NoteFields.task} $textType,
  ${NoteFields.time} $textType,

      )
    ''');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns = 
    //     '${NoteFields.title}, ${NoteFields.task},${NoteFields.time}';
    
    // final values = 
    //     '${json[NoteFields.title]}, ${json[NoteFields.task]},${json[NoteFields.time]}';


    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id:id);
  }


  
  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty){
      return Note.fromJson(maps.first);
    } else{
      throw Exception('ID $id not found');
    }
  }



  Future <List<Note>> readAllNotes() async{
    final db = await instance.database;

    final orderBy = '${NoteFields.time} ASC';
    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }



  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id]
    );
  }


  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id]
      );
  }



  Future close() async {
    final db = await instance.database;
    db.close();

    // var dbClient = await db;
    // dbClient.close();
  }



  // Future<int> update(Category category) async {
  //   var dbClient = await db;
  //   return await dbClient.update(TABLE, category.toMap(),
  //       where: '$ID = ?', whereArgs: [category.id]);
  // }



  // Future<List<Category>> getAllNotes() async {
  //   var dbClient = await db;
  //   List<Map> maps = await dbClient.query(TABLE, columns: [ID, TITLE, TASK]);;
  //   List<Category> notes = [];
  //   if (maps.length > 0) {
  //     for (int i = 0; i < maps.length; i++) {
  //       notes.add(Category.fromMap(maps[i]));
  //     }
  //   }
  //   return notes;
  // }



  // Future<int> delete(int id) async {
  //   var dbClient = await db;
  //   return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  // }



  // Future close() async {
  //   final db = await instance.database;
  //   db.close();

  //   // var dbClient = await db;
  //   // dbClient.close();
  // }

}