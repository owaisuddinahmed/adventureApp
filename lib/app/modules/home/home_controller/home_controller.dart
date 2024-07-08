



import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HomeController extends GetxController {

  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  TextEditingController eventName = TextEditingController();
  TextEditingController eventDescription = TextEditingController();
  TextEditingController eventLocationName = TextEditingController();
  TextEditingController eventDateTime = TextEditingController();


  FocusNode eventNameNode = FocusNode();
  FocusNode eventDescNode = FocusNode();
  FocusNode eventLocNode = FocusNode();
  FocusNode eventDateTimeNode = FocusNode();

  final _db = FirebaseFirestore.instance;

  RxBool isOpen = false.obs;


  void createEvent() {
    Map<String, dynamic> userMap = {
     "event_name":eventName.text,
      "event_description":eventDescription.text,
      "event_location":eventLocationName.text,
      "event_date_time":eventDateTime.text
    };

    String jsonString = jsonEncode(userMap);
    print(jsonString); // For debugging purposes

    _db.collection("event").add(userMap).then((DocumentReference doc) {
      print('User added with ID: ${doc.id}');
      Get.back();
      // Get.toNamed(Routes.LOGINVIEW);
    }).catchError((error) {
      print('Error adding user: $error');
    });
  }

}