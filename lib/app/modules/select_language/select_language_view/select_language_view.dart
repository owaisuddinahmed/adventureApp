import 'dart:io';

import 'package:adventure/app/components/widgets/custom_text.dart';
import 'package:adventure/app/components/widgets/custom_universal_button.dart';
import 'package:adventure/app/modules/select_language/select_language_controller/select_language_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SelectLanguageView extends StatelessWidget {
  SelectLanguageView({Key? key}) : super(key: key);

  final SelectLanguageController controller = Get.put(SelectLanguageController());

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
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 4.h,
        ),
        backgroundColor: Colors.transparent,
        title: CustomText(
          text: 'Select Language',
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          padding: EdgeInsets.all(4.h),
          child: ListView(
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: CustomText(
                      text: "Choose Your Language ",
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Obx(()=> Image.asset(controller.flagImage.value))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomText(
                text: "Please search and then choose your personal language.",
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  shrinkWrap: true,
                  itemCount: controller.languageModel.length,
                  itemBuilder: (context, index) {
                    return Obx(
                        ()=> GestureDetector(
                        onTap: () {
                          for (var model in controller.languageModel) {
                            model.selected!.value = false;
                          }
                          controller.selectedLanguage =  controller.languageModel[index].text??'';
                          controller.languageModel[index].selected!.value = true;
                          controller.flagImage.value =   controller.languageModel[index].image??'';
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: controller.languageModel[index].selected!.value
                              ? BoxDecoration(
                                  color: const Color(0xFFFAFAFA), borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFEEEEEE)))
                              : const BoxDecoration(),
                          child: Row(
                            children: [
                              Image.asset(controller.languageModel[index].image ?? ''),
                              SizedBox(
                                width: 4.w,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: controller.languageModel[index].text ?? '',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    Visibility(
                                      visible: controller.languageModel[index].selected!.value,
                                      child: Container(
                                        width: 5.w,
                                        height: 3.h,
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle
                                        ),
                                        child: SvgPicture.asset("assets/images/tick.svg"),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 10.h,
              ),
              CustomUniversalButton(title: 'Confirm'.tr, height: 6.h, controller: controller.btnController, onTap: () async {
                controller.createUser();

              }),
            ],
          ),
        ),
      ),
    );
  }
}
