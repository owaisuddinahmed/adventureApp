


import 'package:adventure/app/components/widgets/custom_text.dart';
import 'package:adventure/app/modules/home/home_controller/home_controller.dart';
import 'package:adventure/app/modules/home/home_widgets/event_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
   HomeView({super.key});
  final HomeController controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 15.h,
        title: CustomText(
           text: 'Messages',
          fontStyle: FontStyle.italic,
          color: Colors.white,
          fontSize: 14.sp,
        ),
        actions:
           [

            Icon(Icons.search),
            SizedBox(width: 3.w,),
            Icon(Icons.add),
             SizedBox(width: 2.w,),
          ],
        ),
      body: Column(
        children: [
          DefaultTabController(
            length: 4,
            child: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  child: CustomText(
                    text: 'Event',
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Tab(
                  child: CustomText(
                    text: 'Team',
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Tab(
                  child: CustomText(
                    text: 'Task',
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Tab(
                  child: CustomText(
                    text: 'Equipment',
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),

              ],


            ),
          ),
EventTabWidget()
        ],
      ),
    );
  }
}
