import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeCard.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeIntro.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/Searchbar.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/shimmerLoading.dart';
import 'package:jobjetadmin/Screens/HomeScreen/service/Controller.dart';
import 'package:jobjetadmin/Screens/LoginScreen/LoginScreen.dart';
import 'package:jobjetadmin/main.dart';

import 'package:sizer/sizer.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  JobController ctrl = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: 2.h,),
            SearchBarScreen(
              data: ctrl.JobList,
              // notifier: notifier,
            ),
            SizedBox(height: 1.h),

            GetBuilder<JobController>(builder: (context) {
              return Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (!ctrl.postLoading)
                      for (var data in ctrl.JobList)
                        homecard(
                          jobData: data,
                        ),
                    if (!ctrl.postLoading && ctrl.JobList.isEmpty)
                      Container(
                        height: 70.h,
                        alignment: Alignment.center,
                        child: Text("No Post"),
                      ),
                    if (ctrl.postLoading)
                      for (var data in [1, 2, 3, 4, 5]) ShimmerLoadingHomeCard()
                  ],
                ),
              ));
            }),
          ],
        ),
      ),
    );
  }
}
