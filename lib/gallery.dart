import 'package:flutter/material.dart';
import 'package:flutter_project/main.dart';


class galleryPage extends StatelessWidget {
  const galleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
    );
  }
}



class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => new Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: const Image(image: AssetImage('transparent_logo.png'), height: 50,),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          size: 20,
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return const MyHomePage(title: 'Home Page',);
              }));
        },
      ),
    );
  }
}
