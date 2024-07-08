import 'package:adventure/app/modules/home/home_view/home_view.dart';
import 'package:adventure/app/modules/login/login_view/login_view.dart';
import 'package:adventure/app/modules/select_language/select_language_view/select_language_view.dart';
import 'package:adventure/app/modules/sign_up/sign_up_view/sign_up_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGNUPVIEW;

  static final routes = [
    GetPage(
      name: _Paths.SIGNUPVIEW,
      page: () =>  SignUpView(),
    ),
    GetPage(
      name: _Paths.LOGINVIEW,
      page: () => LoginView(),
    ),
    GetPage(
      name: _Paths.SELECTLANGUAGE,
      page: () => SelectLanguageView(),
    ),
    GetPage(
      name: _Paths.HOMEVIEW,
      page: () => HomeView(),
    ),
  ];
}
