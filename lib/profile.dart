import 'package:flutter/material.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/services/DatabaseService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    createUserAndDisplayInfo();
  }

  void createUserAndDisplayInfo() async {
    final defaultUser = User(
      id: 1,
      pseudo: 'harry cover',
      firstname: 'Jean',
      lastname: 'Paul',
      city: 'Rennes',

    );

    await DatabaseService.createUser(defaultUser);

    var userTest = await DatabaseService.getUser(1);

    setState(() {
      _currentUser = User.fromMap(userTest.first);
    });
  }

  void disconnect() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 20),
            ProfileDetail(title: 'Pseudo', value: _currentUser.pseudo),
            ProfileDetail(title: 'Firstname', value: _currentUser.firstname),
            ProfileDetail(title: 'Lastname', value: _currentUser.lastname),
            ProfileDetail(title: 'City', value: _currentUser.city),
            ElevatedButton(
              onPressed: disconnect,
              child: const Text('log out'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final String title;
  final String value;

  const ProfileDetail({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.green,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: const Image(image: AssetImage('transparent_logo.png'), height: 50),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          size: 20,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const MyHomePage(title: 'Home Page');
            },
          ));
        },
      ),
    );
  }
}
