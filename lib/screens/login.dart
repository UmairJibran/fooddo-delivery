import 'package:flutter/material.dart';

import '../services.dart';
import 'home.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  static String pageRoute = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _key;
  String _email = '';
  String _password = '';
  double height;
  double width;
  bool _loading;
  bool _loginFailed;
  String errorMessage;
  @override
  void initState() {
    super.initState();
    _loading = false;
    _loginFailed = false;
    _key = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: _loading
            ? Container(
                height: height,
                width: width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                height: height - 30,
                width: width,
                margin: EdgeInsets.only(top: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Fooddo Delivery",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                fontFamily: "Billabong",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: Form(
                        key: _key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              initialValue: _email,
                              onChanged: (value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter an Email";
                                } else if (!(value.contains('@') &&
                                        value.contains('.')) ||
                                    value.contains(' ')) {
                                  return "Please Enter a Valid Email";
                                } else {
                                  return null;
                                }
                              },
                              enableSuggestions: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Enter your Email",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter a Password";
                                } else if (value.length < 6) {
                                  return "Password is too short";
                                } else {
                                  return null;
                                }
                              },
                              enableSuggestions: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Enter your Password",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _loginFailed
                        ? Container(
                            width: width * 0.9,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Center(
                              child: Text(
                                '$errorMessage',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 14,
                          ),
                    Container(
                      width: width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(SignUp.pageRoute);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_key.currentState.validate()) {
                                setState(() {
                                  _loading = true;
                                });
                                _key.currentState.save();
                                //TODO: Signin with provided email/password
                                String result =
                                    await Services.signIn(_email, _password);
                                if (result == "login-success") {
                                  await Services.fetchUser();
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Home.pageRoute,
                                  );
                                } else {
                                  setState(() {
                                    _loginFailed = true;
                                    switch (result) {
                                      case "user-not-found":
                                        result =
                                            "No user found with that email";
                                        break;
                                      case "wrong-password":
                                        result =
                                            "Please double check your password";
                                        break;
                                      default:
                                        result =
                                            "An error occured while trying to log in, please try again";
                                        break;
                                    }
                                    errorMessage = result;
                                  });
                                }
                                setState(() {
                                  _loading = false;
                                });
                              }
                            },
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
