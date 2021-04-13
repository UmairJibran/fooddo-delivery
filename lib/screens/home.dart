import 'package:flutter/material.dart';

import '../services.dart';

class Home extends StatelessWidget {
  static final pageRoute = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fooddo Delivery",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(Data.loggedInDeliveryPerson.vehicleCapacity.toString()),
        ),
      ),
    );
  }
}
