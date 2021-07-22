import 'package:flutter/material.dart';
import 'package:fooddo_delivery/classes/city.dart';

import '../services.dart';
import 'home.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  static final String pageRoute = "/signUp";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _loading = false;
  double height;
  double width;
  var _formKey;
  String _completeName = '';
  String _email = '';
  String _password = '';
  String _errorMessage = '';
  bool _wrongCred;
  String _phoneNumber = '';
  int _vehicleCapacity = 0;
  List<City> cities = <City>[
    City("Peshawar"),
    City("Lahore"),
    City("Islamabad"),
    City("Mardan"),
    City("Nowshehra")
  ];

  City _city;

  @override
  void initState() {
    super.initState();
    _wrongCred = false;
    _formKey = GlobalKey<FormState>();
    _city = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _loading
          ? Container(
              height: height,
              width: width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: height - 30,
                width: width,
                margin: EdgeInsets.only(top: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                                fontFamily: "Billabong",
                                fontSize: 50,
                                letterSpacing: 2,
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
                        key: _formKey,
                        child: Container(
                          height: height * 0.6,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  initialValue: _completeName,
                                  onChanged: (value) {
                                    setState(() {
                                      _completeName = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please Enter a name";
                                    }
                                    if (value.contains('1') ||
                                        value.contains('2') ||
                                        value.contains('3') ||
                                        value.contains('4') ||
                                        value.contains('5') ||
                                        value.contains('6') ||
                                        value.contains('6') ||
                                        value.contains('7') ||
                                        value.contains('8') ||
                                        value.contains('9') ||
                                        value.contains('0')) {
                                      return "Name can not have numbers";
                                    } else if (value.trim().length < 3) {
                                      return "Please Enter your Complete Name";
                                    } else {
                                      return null;
                                    }
                                  },
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                    hintText: "Enter your Name",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  initialValue: _email,
                                  onChanged: (value) {
                                    setState(() {
                                      _email = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please Enter your Email";
                                    } else if (value.contains(' ') ||
                                        !(value.contains('@') &&
                                            value.contains('.'))) {
                                      return "Please Enter a valid Email";
                                    } else {
                                      return null;
                                    }
                                  },
                                  textCapitalization: TextCapitalization.none,
                                  enableSuggestions: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "Enter your Email",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  initialValue: _phoneNumber,
                                  onChanged: (value) {
                                    setState(() {
                                      _phoneNumber = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please Enter your phone Number";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                    hintText: "Please Enter your phone Number",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  initialValue: _vehicleCapacity.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      _vehicleCapacity = int.parse(value);
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please Enter capacity(per meal) of your vehicle";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Please Enter capacity(per meal) of your vehicle",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                DropdownButton<City>(
                                  hint: Text("Select a city"),
                                  value: _city,
                                  onChanged: (City selected) => {
                                    setState(
                                      () {
                                        _city = selected;
                                      },
                                    ),
                                  },
                                  items: cities.map(
                                    (City city) {
                                      return DropdownMenuItem<City>(
                                        value: city,
                                        child: Text(city.name),
                                      );
                                    },
                                  ).toList(),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      _password = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please Enter Password";
                                    } else if (value.length < 6) {
                                      return "Password Must be atleast 6 characters";
                                    } else {
                                      return null;
                                    }
                                  },
                                  enableSuggestions: false,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Enter your Password",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please Enter Password";
                                    } else if (value.length < 6) {
                                      return "Password Must be atleast 6 characters";
                                    } else if (_password != value) {
                                      return "Password doesn't match";
                                    } else {
                                      return null;
                                    }
                                  },
                                  enableSuggestions: false,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Re-Enter your Password",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    _wrongCred
                        ? Container(
                            width: width * 0.9,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Center(
                              child: Text(
                                '$_errorMessage',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'SulphurPoint',
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
                            // padding: EdgeInsets.symmetric(
                            //   vertical: 10,
                            //   horizontal: 25,
                            // ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(Login.pageRoute);
                            },
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _loading = true;
                                });
                                _formKey.currentState.save();
                                String result = await Services.signUp(
                                  _email,
                                  _password,
                                  _completeName,
                                  _phoneNumber,
                                  _city.name,
                                  _vehicleCapacity,
                                );
                                if (result == "user-created") {
                                  await Services.fetchUser();
                                  Navigator.of(context)
                                      .pushReplacementNamed(Home.pageRoute);
                                } else {
                                  setState(() {
                                    _wrongCred = true;
                                    _errorMessage = result;
                                  });
                                }
                                setState(() {
                                  _loading = false;
                                });
                              }
                            },
                            child: Text(
                              "Sign Up",
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
