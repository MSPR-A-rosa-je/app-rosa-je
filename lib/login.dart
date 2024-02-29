import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class loginPage extends StatelessWidget {
  const loginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String _username;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _username = value;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
            obscureText: true,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            login(_username, _password);
            },
          child: const Text('Valider'),
        ),
      ],
    );
  }
}

Future<void> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:8000/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    final String accessToken = responseJson['access_token'];
    // Store the token securely
    // Navigate to the home screen
  } else {
    // Handle errors
  }
}
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key});

  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: const Image(image: AssetImage('transparent_logo.png'), height: 50,),
    );
  }
}
