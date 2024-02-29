import '../services/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

class InsertUserWidget extends StatefulWidget {
  const InsertUserWidget({Key? key}) : super(key: key);
  static const userTable = 'users';
  @override
  _InsertUserWidgetState createState() => _InsertUserWidgetState();
}

class _InsertUserWidgetState extends State<InsertUserWidget> {
  Future<List<Map<String, dynamic>>> _getData() async{
    Database db = await DatabaseService.db();
    return DatabaseService.getUser(1);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          return Text(snapshot.data.toString());
        }
        return const Text('error');
      },
    );
  }
}
