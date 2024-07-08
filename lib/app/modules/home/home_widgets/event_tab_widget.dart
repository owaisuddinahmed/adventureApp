

import 'package:adventure/app/components/utils/Util.dart';
import 'package:adventure/app/components/widgets/custom_text.dart';
import 'package:adventure/app/components/widgets/custom_textfield.dart';
import 'package:adventure/app/components/widgets/custom_universal_button.dart';
import 'package:adventure/app/modules/home/home_controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EventTabWidget extends StatelessWidget {
   EventTabWidget({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomRight,

        children: [

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

      Expanded(
        child: StreamBuilder<QuerySnapshot>(

        stream: FirebaseFirestore.instance.collection('event').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(text: "Add a new Event!",fontWeight: FontWeight.bold,),
                  SizedBox(height: 2.h,),
                  const CustomText(text: "Invite the  Location Admins to their new\nEvent and Management App",
                    center: true,
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.only(top: 2.h, bottom: 1.h, left: 10, right: 10),
                  child: CustomText(
                    text: "Recent",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }

              var event = snapshot.data!.docs[index - 1].data() as Map<String, dynamic>;
              var eventName = event['event_name'] ?? 'Event Name Missing';
              var desc = event['event_description'] ?? 'Event Description Missing';
              var loc = event['event_location'] ?? 'Event Location Missing';
              var date = event['event_date_time'] ?? 'Event Date Missing';

              return Container(
                margin: const EdgeInsets.all(10),
                height: 20.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color(0xFFEEEEEE)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset("assets/images/event.png"),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomText(
                                text: eventName,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Flexible(
                            child: CustomText(
                              text: desc,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF5F5F5F),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Flexible(
                            child: CustomText(
                              text: loc,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.italic,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Flexible(
                            child: CustomText(
                              text: date,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.italic,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
    ),
      ),






          ],
        ),
          Padding(
            padding:  EdgeInsets.only(bottom: 5.h,right: 5.h),
            child:Obx(()=> !controller.hideFloatingBtn.value? FloatingActionButton(onPressed: (){

              controller.isOpen.value = !controller.isOpen.value;
              controller.hideFloatingBtn.value = !controller.hideFloatingBtn.value;
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isDismissible: false,
                  builder: (BuildContext context) {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.h, right: 6.h),
                          child: GestureDetector(
                            onTap: () {
                              controller.hideFloatingBtn.value = !controller.hideFloatingBtn.value;
                              Get.back();
                              createEvent(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                  ),
                                  child: CustomText(text: "Create Event",
                                    fontStyle: FontStyle.italic,
                                    fontSize: 10.sp,
                                  ),

                                ),
                                SizedBox(width: 2.w,),
                                SvgPicture.asset(
                                  "assets/images/circle_icon.svg",
                                  height: 5.h, width: 7.w,)
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 5.h, right: 5.h),
                          child: FloatingActionButton(onPressed: () {
                            controller.hideFloatingBtn.value = !controller.hideFloatingBtn.value;

                            Get.back();
                          },
                            backgroundColor: Colors.black,
                            child: const Icon(Icons.close),),
                        )
                      ],
                    );
                  }, isScrollControlled: false, context: context);
            },
              backgroundColor: Colors.black,
              child: const Icon(Icons.add),
            ):const SizedBox.shrink()),
          )

        ],
      ),
    );
  }


  createEvent(context){
    showDialog(

        context: context, builder: (BuildContext c){
      return AlertDialog(
        scrollable: true,

shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10)
),
        title: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    CustomText(text: "Create Event", fontSize: 14.sp,fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: (){Get.back();},
                        child: Icon(Icons.close))
                  ],
                ),
                CustomTextField(
                  hintText: "Event Name",
                  controller: controller.eventName,
                  focusNode: controller.eventNameNode,
                  shape: FloatingEditTextShape.RoundedBorder14,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  // limit: AppConstants.userNameMaxLimit,
                  validator: (v) {
                    return Util.fieldCannotBeEmpty(v, fieldName: "Event Name".tr);
                  },
                ),
                SizedBox(height: 2.h,),
                CustomTextField(
                  hintText: "Event Location Name",
                  controller: controller.eventLocationName,
                  focusNode: controller.eventLocNode,
                  shape: FloatingEditTextShape.RoundedBorder14,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  // limit: AppConstants.userNameMaxLimit,
                  validator: (v) {
                    return Util.fieldCannotBeEmpty(v, fieldName: "Event Location Name".tr);
                  },
                ),
                SizedBox(height: 2.h,),

                CustomTextField(
                  hintText: "Event Date And Time",
                  controller: controller.eventDateTime,
                  focusNode: controller.eventDateTimeNode,
                  shape: FloatingEditTextShape.RoundedBorder14,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  // limit: AppConstants.userNameMaxLimit,
                  validator: (v) {
                    return Util.fieldCannotBeEmpty(v, fieldName: "Event Date And Time".tr);
                  },
                ),
                SizedBox(height: 2.h,),

                CustomTextField(
                  hintText: "Event Description",
                  controller: controller.eventDescription,
                  focusNode: controller.eventDescNode,
                  shape: FloatingEditTextShape.RoundedBorder14,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  // limit: AppConstants.userNameMaxLimit,
                  validator: (v) {
                    return Util.fieldCannotBeEmpty(v, fieldName: "Event Description".tr);
                  },
                ),

                SizedBox(height: 4.h,),
                CustomUniversalButton(
                  title: 'Create Event'.tr,
                  height: 6.h,
                  controller: controller.btnController,
                  onTap: () async {
                    if(controller.formKey.currentState!.validate()) {
                      controller.createEvent();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }


}
