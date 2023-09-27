import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isAuth = false;
  int? level;

  void _checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('appToken');
    level = prefs.getInt('userLevel');
    if (token != null && level != null && context.mounted) {
      setState(() {
        _isAuth = true;
      });
    }
    _getInit();
  }

  void _checkLevel() {
    switch (level) {
      case 4:
        Navigator.pushReplacementNamed(context, '/home-admin');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/home-sekda');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/home-atasan');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/home-petugas');
        break;
      default:
        Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  _getInit() async {
    Timer(
        const Duration(seconds: 2),
        () => _isAuth
            ? _checkLevel()
            : Navigator.pushReplacementNamed(context, '/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo.png', height: 100),
      ),
    );
  }
}
