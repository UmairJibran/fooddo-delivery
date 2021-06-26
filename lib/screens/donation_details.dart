import 'package:flutter/material.dart';
import 'package:fooddo_delivery/classes/donation.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../services.dart';

class DonationDetails extends StatefulWidget {
  static final pageRoute = "/donation-deatil";

  @override
  _DonationDetailsState createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  bool updating;

  @override
  void initState() {
    super.initState();
    updating = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    final Donation donation = args["donation"];
    final String assignmentId = args["assignmentId"];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Fooddo",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 45,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Delivery",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          if (updating)
            LinearProgressIndicator(
              backgroundColor: Colors.green,
            ),
          Container(
            height: height * 0.3,
            width: width,
            child: Image.network(
              "${donation.imgUrl}",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Color(0xffEBF4FF),
            height: height * 0.065,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Serves ${donation.serving} People",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.people_outline, size: 20, color: Colors.black),
              ],
            ),
          ),
          Container(
            width: width * 0.9,
            height: height * 0.4,
            margin: EdgeInsets.only(
              top: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pick Up Address",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        if (donation.status == "completed")
                          Icon(
                            Icons.done_all_outlined,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          )
                        else if (donation.status == "collecting")
                          Icon(
                            Icons.local_shipping_outlined,
                            color: Colors.cyan,
                          )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        donation.pickupAddress,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                if (donation.status == "collecting")
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined),
                        Text(
                          "Get Directions",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    onPressed: () {
                      MapsLauncher.launchCoordinates(
                        donation.longlat["latitude"],
                        donation.longlat["longitude"],
                      );
                    },
                  ),
                if (donation.status == "collecting")
                  FlatButton(
                    onPressed: () async {
                      setState(() {
                        updating = true;
                      });
                      await Services.donationRecieved(
                        donation.id,
                        assignmentId,
                      );
                      await Services.fetchAssignments();
                      setState(() {
                        updating = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Confirm Recieved",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                if (donation.status == "completed")
                  Text(
                    "Completed!",
                    style: TextStyle(color: Colors.black),
                  ),
              ],
            ),
          ),
          FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Call Donor"), Icon(Icons.call)],
            ),
            onPressed: () async {
              bool res = await FlutterPhoneDirectCaller.callNumber(
                  "+${donation.donorId}");
            },
          ),
        ],
      ),
    );
  }
}
