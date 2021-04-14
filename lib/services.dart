import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooddo_delivery/classes/delivery_person.dart';
import 'package:intl/intl.dart';

import 'classes/assignment.dart';
import 'classes/donation.dart';

class Data {
  static DeliveryPerson loggedInDeliveryPerson;
  static String userDocId;
  static List<Assignment> assignments = [];
  static List<Assignment> completedAssignments = [];
}

class Services {
  static Future<bool> checkIfLoggedIn() async {
    bool isLoggedIn;
    await FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null)
        isLoggedIn = false;
      else {
        String docId = user.email.replaceAll("@", "").replaceAll(".", "");
        Data.userDocId = docId;
        isLoggedIn = true;
      }
    });
    return isLoggedIn;
  }

  static Future<String> signUp(
    String email,
    String password,
    String name,
    String phoneNumber,
    String city,
    int vehicleCapacity,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      String docId = email.replaceAll("@", "").replaceAll(".", "");
      Data.userDocId = docId;
      await firebaseFirestore.collection("deliverypersons").doc(docId).set({
        "city": city,
        "name": name,
        "phone": phoneNumber,
        "vehicleCapacity": vehicleCapacity,
      });
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "user-created";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return e.code;
      } else
        return e.code;
    } catch (e) {
      return (e);
    }
  }

  static Future<String> signIn(
    String email,
    String password,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      String docId = email.replaceAll("@", "").replaceAll(".", "");
      Data.userDocId = docId;
      return "login-success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return (e.code);
      } else if (e.code == 'wrong-password') {
        return (e.code);
      }
    } catch (e) {
      return e.code;
    }
  }

  static fetchUser() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot doc = await firebaseFirestore
        .collection("deliverypersons")
        .doc(Data.userDocId)
        .get();
    if (doc.exists) {
      Data.loggedInDeliveryPerson = new DeliveryPerson(
        doc["name"],
        doc["city"],
        doc["phone"],
        doc["vehicleCapacity"],
      );
    }
    await Services.fetchAssignments();
  }

  static fetchAssignments() async {
    Data.assignments.clear();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var assignments = await firebaseFirestore
        .collection("deliverypersons")
        .doc(Data.userDocId)
        .collection("assignments")
        .get();

    if (assignments.docs.length == 0) return;
    assignments.docs.forEach((assignment) {
      print(assignment["donationId"]);
      Data.assignments.add(new Assignment(
        id: assignment.id,
        donationId: assignment["donationId"],
        donorContact: assignment["donorContact"],
        pickUpAddress: assignment["pickUpAddress"],
        servings: assignment["servings"],
        date: assignment["date"],
      ));
    });
  }

  static fetchDonation(String donationId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var doc =
        await firebaseFirestore.collection("donations").doc(donationId).get();
    var documentData = doc.data();
    return new Donation(
      id: doc.id,
      city: documentData["city"],
      date: documentData["date"],
      donorId: documentData["donorId"],
      imgUrl: documentData["imgUrl"],
      pickupAddress: documentData["pickupAddress"],
      serving: documentData["servings"],
      status: documentData["status"],
    );
  }

  static donationRecieved(String donationId, String assignmentId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot doc =
        await firebaseFirestore.collection("donations").doc(donationId).get();
    if (doc.exists) {
      var donationDocument = doc.data();
      await firebaseFirestore
          .collection("users")
          .doc(donationDocument["donorId"])
          .collection("notifications")
          .add(
        {
          "donationId": doc.id,
          "status": "completed",
          "timeStamp": DateFormat.yMMMEd().format(DateTime.now()).toString(),
        },
      );
      donationDocument["status"] = "completed";
      firebaseFirestore
          .collection("donations")
          .doc(donationId)
          .update(donationDocument);
      var assignment = await firebaseFirestore
          .collection("deliverypersons")
          .doc(Data.userDocId)
          .collection("assignments")
          .doc(assignmentId)
          .get();
      var assignmentData = assignment.data();
      await firebaseFirestore
          .collection("deliverypersons")
          .doc(Data.userDocId)
          .collection("completedassignments")
          .add(assignmentData);
      await firebaseFirestore
          .collection("deliverypersons")
          .doc(Data.userDocId)
          .collection("assignments")
          .doc(assignmentId)
          .delete();
    }
  }

  static fetchCompletedAssignments() async {
    Data.completedAssignments.clear();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var completedAssignments = await firebaseFirestore
        .collection("deliverypersons")
        .doc(Data.userDocId)
        .collection("completedassignments")
        .get();

    if (completedAssignments.docs.length == 0) return;
    completedAssignments.docs.forEach((assignment) {
      Data.completedAssignments.add(new Assignment(
        id: assignment.id,
        donationId: assignment["donationId"],
        donorContact: assignment["donorContact"],
        pickUpAddress: assignment["pickUpAddress"],
        servings: assignment["servings"],
        date: assignment["date"],
      ));
    });
  }
}
