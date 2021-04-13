import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddo_delivery/screens/login.dart';
import 'package:fooddo_delivery/screens/signup.dart';
import 'package:fooddo_delivery/screens/splash_screen.dart';

import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(242, 166, 66, 1),
        fontFamily: "Raleway",
      ),
      routes: {
        "/": (ctx) => SplashScreen(),
        Home.pageRoute: (ctx) => Home(),
        Login.pageRoute: (ctx) => Login(),
        SignUp.pageRoute: (ctx) => SignUp(),
      },
    );
  }
}
