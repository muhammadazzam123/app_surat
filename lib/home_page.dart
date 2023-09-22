import 'package:app_surat/navbar.dart';
import 'package:app_surat/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: primaryColor,
                ))),
      ),
      drawer: NavBar(),
      body: Center(
        child: Text('Main Page'),
      ),
    );
  }
}
