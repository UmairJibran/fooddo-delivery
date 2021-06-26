import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  final String id;
  final String donationId;
  final String donorContact;
  final String pickUpAddress;
  final int servings;
  final String date;
  final Map<String, dynamic> longlat;
  final Timestamp time;
  final String name;
  final String recipientCharity;
  final bool seen;

  Assignment({
    this.id,
    this.donationId,
    this.donorContact,
    this.pickUpAddress,
    this.servings,
    this.date,
    this.longlat,
    this.seen,
    this.recipientCharity,
    this.name,
    this.time,
  });
}
