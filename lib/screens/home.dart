import 'package:flutter/material.dart';
import 'package:fooddo_delivery/classes/donation.dart';
import 'package:fooddo_delivery/screens/donation_details.dart';
import 'package:fooddo_delivery/screens/login.dart';

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
          ),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await Services.logout();
                Navigator.of(context).pushReplacementNamed(Login.pageRoute);
              })
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
                      ElevatedButton(
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
                        return ElevatedButton(
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
                        title: RichText(
                          text: TextSpan(
                            text: "${Data.assignments[index - 1].name}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: " to ",
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                              TextSpan(
                                text:
                                    "${Data.assignments[index - 1].recipientCharity}",
                              ),
                            ],
                          ),
                        ),
                        trailing: Data.assignments[index - 1].seen
                            ? Container(
                                height: 10,
                                width: 10,
                              )
                            : Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Data.assignments[index - 1].pickUpAddress,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              DateTime.fromMicrosecondsSinceEpoch(Data
                                      .assignments[index - 1]
                                      .time
                                      .microsecondsSinceEpoch)
                                  .toString(),
                            )
                          ],
                        ),
                        onTap: () async {
                          setState(() {
                            _loading = true;
                          });
                          Donation donation = await Services.fetchDonation(
                            Data.assignments[index - 1].donationId,
                          );
                          await Services.assignmentSeen(
                              Data.assignments[index - 1].id);
                          Data.assignments[index - 1].seen = true;

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
