import 'package:sqflite/sqflite.dart';
import '../services/DatabaseService.dart';

class User {
  final int? id;
  final String pseudo;
  final String firstname;
  final String lastname;
  final String city;
  static const String table = "users";

  User({
    this.id,
    required this.pseudo,
    required this.firstname,
    required this.lastname,
    required this.city,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pseudo': pseudo,
      'age': firstname,
      'club': lastname,
      'city': city,

    };
  }

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["id"],
      pseudo: json["pseudo"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      city: json["city"],
  );


  @override
  String toString() {
    return 'User(id: $id, pseudo: $pseudo, firstname: $firstname, lastname: $lastname, city:$city';
  }

  Future<void> insert(User user) async {
    final database = await DatabaseService.db();
    await database.insert(
      table,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

