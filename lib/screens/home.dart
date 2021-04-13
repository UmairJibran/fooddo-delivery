import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static final pageRoute = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}
