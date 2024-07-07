import 'dart:convert';
import 'dart:io';

import 'package:adventure/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


class SelectLanguageController extends GetxController {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();


  RxString flagImage = "assets/images/english.png".obs;


List<SelectLanguageModel> languageModel =[
  SelectLanguageModel("English", true.obs,"assets/images/english.png"),
  SelectLanguageModel("Italian", false.obs,"assets/images/italian.png"),
  SelectLanguageModel("Chinese", false.obs,"assets/images/chinese.png"),
  SelectLanguageModel("French", false.obs,"assets/images/french.png"),
  SelectLanguageModel("German", false.obs,"assets/images/germany.png"),
  SelectLanguageModel("Spanish", false.obs,"assets/images/spanish.png"),
  SelectLanguageModel("Russian", false.obs,"assets/images/russian.png"),

];

var arguments = Get.arguments;

String email = "";
String selectedLanguage = "English";


final _db = FirebaseFirestore.instance;

  @override
  void onInit() {
   if(arguments != null && arguments["email"] != null){
     email = arguments["email"];
   }
    super.onInit();
  }


  void createUser() {
    Map<String, dynamic> userMap = {
      "email": email,
      "language": selectedLanguage,
    };

    String jsonString = jsonEncode(userMap);
    print(jsonString); // For debugging purposes

    _db.collection("user").add(userMap).then((DocumentReference doc) {
      print('User added with ID: ${doc.id}');
      Get.toNamed(Routes.LOGINVIEW);
    }).catchError((error) {
      print('Error adding user: $error');
    });
  }



}


class SelectLanguageModel{

  String? text;
  RxBool? selected;
  String? image;


  SelectLanguageModel(this.text,this.selected,this.image);


}