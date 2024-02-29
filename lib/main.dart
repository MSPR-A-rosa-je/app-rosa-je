import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'login.dart';
import 'photo.dart';
import 'gallery.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfiWeb;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Arosa-je';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _token = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        token: _token,
        logout: logout,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: InteractiveViewer(
                maxScale: 2.0,
                minScale: 0.5,
                boundaryMargin: EdgeInsets.all(20),
                child: Image.asset(
                  'transparent_name.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        shadowColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Image(image: AssetImage('transparent_logo.png'))),
            ListTile(
              title: const Text('Homepage'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return MyHomePage(title: 'Home Page');
                  }),
                );
              },
            ),
            ListTile(
              title: const Text('Photos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const PhotoPage();
                  }),
                );
              },
            ),
            ListTile(
              title: const Text('Login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const loginPage();
                  }),
                );
              },
            ),
            ListTile(
              title: const Text('Gallery'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const galleryPage();
                  }),
                );
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const ProfilePage();
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(String token) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        _token = '';
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const loginPage()),
      );
    } else {
    }
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String token;
  final void Function(String) logout;
  const MyAppBar({
    Key? key,
    required this.title,
    required this.token,
    required this.logout,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: const Image(image: AssetImage('transparent_logo.png'), height: 50,),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => logout(token),
        ),
      ],
    );
  }
}
