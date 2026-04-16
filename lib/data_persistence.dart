import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataPersistencePage extends StatefulWidget {
  final String title;

  const DataPersistencePage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() {
    return _DataPersistencePageState();
  }

}

class _DataPersistencePageState extends State<DataPersistencePage> {

  fileDemo() {
    _readFileContent().then((value){
      print("before:$value");
      _writeFileContent('$value .').then((_){
        _readFileContent().then((value)=>print("after:$value"));
      });
    });
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/content.txt');
  }

  Future<File> _writeFileContent(String content) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString(content);
  }

  Future<String> _readFileContent() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }

  spDemo() {
    _readSPCounter().then((value){
      print("before:$value");
      _writeSPCounter().then((_){
        _readSPCounter().then((value)=>print("after:$value"));
      });
    });
  }


  Future<int>_readSPCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int  counter = (prefs.getInt('counter') ?? 0);
    return counter;
  }

  Future<void>_writeSPCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    prefs.setInt('counter', counter);
  }

  int studentID = 123;
  dbDemo () async{
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'students_database.db'),
      onCreate: (db, version)=>db.execute("CREATE TABLE students(id TEXT PRIMARY KEY, name TEXT, score INTEGER)"),
      onUpgrade: (db, oldVersion, newVersion){
        //dosth for migration
        print("old:$oldVersion,new:$newVersion");
      },
      version: 1,
    );

    Future<void> insertStudent(Student std) async {
      final Database db = await database;
      await db.insert(
        'students',
        std.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<List<Student>> students() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('students');
      return List.generate(maps.length, (i)=>Student.fromJson(maps[i]));
    }


    var student1 = Student(id: '${++studentID}', name: '张三', score: 90);
    var student2 = Student(id: '${++studentID}', name: '李四', score: 80);
    var student3 = Student(id: '${++studentID}', name: '王五', score: 85);

    // Insert a dog into the database.
    await insertStudent(student1);
    await insertStudent(student2);
    await insertStudent(student3);

    students().then((list)=>list.forEach((s)=>print('id:${s.id},name:${s.name}')));
    final Database db = await database;
    db.close();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Column(
        children: [
          TextButton(onPressed: () => fileDemo(), child: const Text("文件demo")),
          TextButton(onPressed: () => spDemo(), child: const Text("SharedPreference demo")),
          TextButton(onPressed: () => dbDemo(), child: const Text("数据库demo"))
        ],
      ),
    );
  }

}

class Student{
  String id;
  String name;
  int score;

  Student({required this.id, required this.name, required this.score,});
  factory Student.fromJson(Map<String, dynamic> parsedJson){
    return Student(
      id: parsedJson['id'],
      name : parsedJson['name'],
      score : parsedJson ['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'score': score,};
  }
}

class DataPersistenceApp extends StatelessWidget {
  const DataPersistenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "data persistence demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DataPersistencePage(title: 'data persistence'),
    );
  }

}

void main() => runApp(const DataPersistenceApp());