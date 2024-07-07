import 'dart:io';

import 'package:adventure/app/components/utils/Util.dart';
import 'package:adventure/app/components/widgets/custom_text.dart';
import 'package:adventure/app/components/widgets/custom_textfield.dart';
import 'package:adventure/app/components/widgets/custom_universal_button.dart';
import 'package:adventure/app/modules/login/login_controller/login_controller.dart';
import 'package:adventure/app/modules/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:adventure/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.white,
          statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.light,
          statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.light),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: CustomText(
          text: 'Sign In',
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Form(
          key: controller.formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(8.h),
            children: [
              CustomText(
                text: "Hello there 👋",
                fontWeight: FontWeight.w700,
                fontSize: 26.sp,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomText(
                text: "Please enter your username/email and password to sign In.",
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomText(
                text: "Username / Email",
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomTextField(
                hintText: "Username / Email",
                controller: controller.userNameController,
                focusNode: controller.userNameNode,
                shape: FloatingEditTextShape.RoundedBorder14,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                // limit: AppConstants.userNameMaxLimit,
                validator: (v) {
                  return Util.fieldCannotBeEmpty(v, fieldName: "user_name_or_email".tr);
                },
              ),
              SizedBox(
                height: 4.h,
              ),
              CustomText(
                text: "Password",
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
              SizedBox(
                height: 1.h,
              ),
              Obx(
                () => CustomTextField(
                  hintText: "Password".tr,
                  controller: controller.passwordController,
                  focusNode: controller.passwordNode,
                  shape: FloatingEditTextShape.RoundedBorder14,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  isObscureText: controller.showPassword.value,
                  suffix: InkWell(
                    onTap: () {
                      controller.showPassword.value = !controller.showPassword.value;
                    },
                    child: Container(
                      child: controller.showPassword.value
                          ? Icon(
                              Icons.remove_red_eye,
                              size: 4.h,
                              color: Colors.black,
                            )
                          : Padding(
                              padding: EdgeInsets.all(1.h),
                              child: SvgPicture.asset(
                                "assets/images/Hide.svg",
                                height: 2.h,
                              )),
                    ),
                  ),
                  validator: (v) {
                    return Util.passwordValidate(v!, fieldName: "password".tr);
                  },
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.rememberMe.value = !controller.rememberMe.value;
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 3.5.h,
                        width: 6.w,
                        padding: EdgeInsets.all(0.5.h),
                        decoration: BoxDecoration(
                            color: controller.rememberMe.value ? Colors.black : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black)),
                        child: SvgPicture.asset("assets/images/tick.svg"),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      CustomText(
                        text: "Remember me",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomUniversalButton(
                title: 'Sign Up'.tr,
                height: 6.h,
                controller: controller.btnController,
                onTap: () async {
                  if (controller.formKey.currentState!.validate()) {
                    // controller.signUp(context);
                  }
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Don’t have an account? ",
                    fontSize: 14.sp,
                    fontStyle: FontStyle.italic,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.signIn(controller.userNameController.text, controller.passwordController.text, context);
                      }
                    },
                    child: CustomText(
                      text: "Sign Up",
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
