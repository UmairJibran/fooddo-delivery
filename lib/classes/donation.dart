import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  final String id;
  final String imgUrl;
  final int serving;
  final String status;
  final String date;
  final String pickupAddress;
  final String donorId;
  final String city;
  final Map<String, dynamic> longlat;
  final String donorName;
  final String recepient;
  final Timestamp timeStamp;

  Donation({
    this.id,
    this.donorId,
    this.pickupAddress,
    this.imgUrl,
    this.serving,
    this.status,
    this.date,
    this.city,
    this.longlat,
    this.donorName,
    this.recepient,
    this.timeStamp,
  });
}
