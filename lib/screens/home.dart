import 'package:flutter/material.dart';
import 'package:fooddo_delivery/classes/donation.dart';
import 'package:fooddo_delivery/screens/donation_details.dart';

import '../services.dart';
import 'completed_assignments.dart';

class Home extends StatefulWidget {
  static final pageRoute = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = false;
  }

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
        actions: [
          IconButton(
            icon: Icon(Icons.done_all_outlined),
            onPressed: () async {
              setState(() {
                _loading = true;
              });
              await Services.fetchCompletedAssignments();
              Navigator.of(context).pushNamed(CompletedAssignments.pageRoute);
              setState(() {
                _loading = false;
              });
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : Data.assignments.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        child: Text(
                          "Refresh!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });
                          await Services.fetchAssignments();
                          setState(() {
                            _loading = false;
                          });
                        },
                      ),
                      Text(
                        "No New Assignments!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: Data.assignments.length + 1,
                    itemBuilder: (_, index) {
                      if (index == 0)
                        return FlatButton(
                          child: Text(
                            "Refresh!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });
                            await Services.fetchAssignments();
                            setState(() {
                              _loading = false;
                            });
                          },
                        );
                      return ListTile(
                        leading: Text(index.toString()),
                        title: Text(Data.assignments[index - 1].donationId),
                        subtitle: Text(
                          Data.assignments[index - 1].pickUpAddress,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () async {
                          setState(() {
                            _loading = true;
                          });
                          Donation donation = await Services.fetchDonation(
                            Data.assignments[index - 1].donationId,
                          );
                          setState(() {
                            _loading = false;
                          });
                          Navigator.of(context).pushNamed(
                            DonationDetails.pageRoute,
                            arguments: {
                              "donation": donation,
                              "assignmentId": Data.assignments[index - 1].id,
                            },
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
