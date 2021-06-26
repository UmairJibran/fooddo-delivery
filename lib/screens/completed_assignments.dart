import 'package:flutter/material.dart';
import 'package:fooddo_delivery/classes/donation.dart';

import '../services.dart';
import 'donation_details.dart';

class CompletedAssignments extends StatefulWidget {
  static final pageRoute = "/completed-assignments";

  @override
  _CompletedAssignmentsState createState() => _CompletedAssignmentsState();
}

class _CompletedAssignmentsState extends State<CompletedAssignments> {
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
      ),
      body: Container(
          child: Data.completedAssignments.length > 0
              ? Stack(
                  children: [
                    if (_loading) Center(child: CircularProgressIndicator()),
                    ListView.builder(
                      itemCount: Data.completedAssignments.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: Text((index + 1).toString()),
                          title: Text(
                            "${Data.completedAssignments[index].name} => ${Data.completedAssignments[index].recipientCharity}",
                          ),
                          trailing: Data.completedAssignments[index].seen
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
                                Data.completedAssignments[index].pickUpAddress,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                DateTime.fromMicrosecondsSinceEpoch(
                                  Data.completedAssignments[index].time
                                      .microsecondsSinceEpoch,
                                ).toString(),
                              )
                            ],
                          ),
                          onTap: () async {
                            setState(() {
                              _loading = true;
                            });
                            Donation donation = await Services.fetchDonation(
                              Data.completedAssignments[index].donationId,
                            );
                            setState(() {
                              _loading = false;
                            });
                            Navigator.of(context).pushNamed(
                              DonationDetails.pageRoute,
                              arguments: {
                                "donation": donation,
                                "assignmentId":
                                    Data.completedAssignments[index].id,
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              : Center(
                  child: Text("No completed assignments"),
                )),
    );
  }
}
