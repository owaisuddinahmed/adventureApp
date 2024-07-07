import 'dart:convert';
import 'dart:io';

import 'package:adventure/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


class LoginController extends GetxController {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  // final AppPreferences appPreferences = AppPreferences();

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();


  FocusNode? confirmPasswordNode = FocusNode();

  FocusNode? passwordNode = FocusNode();

  FocusNode? userNameNode = FocusNode();

  RxBool showPassword = false.obs;

  RxBool showConfirmPassword = false.obs;

  RxBool rememberMe = false.obs;


  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  Future<User?> signIn(String email, String password,context) async {
    btnController.start();
    try{
      UserCredential credential =await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      btnController.stop();
      Get.toNamed(Routes.LOGINVIEW);
      return credential.user;
    }
    catch(e){
      btnController.stop();
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
        content: Text("Please Enter valid email address"),
      ));
      print("Some error $e}");
    }
    return null;
  }


}
