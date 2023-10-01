import 'package:flutter/material.dart';

class SnackBarService {
  void showSnackBar(String text, BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
