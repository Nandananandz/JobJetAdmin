import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeCard.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeIntro.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/Searchbar.dart';
import 'package:jobjetadmin/Screens/LoginScreen/LoginScreen.dart';
import 'package:jobjetadmin/main.dart';

import 'package:sizer/sizer.dart';

List categoriesList = [];
List locationList = [];

List fullLocation = [];
List fullCategory = [];

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  loadCategory() async {
    final Response = await get(Uri.parse(baseUrl + "categories"), headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
      "Vary": "Accept"
    });

    categoriesList.clear();
    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      fullCategory = js["data"];
      for (var data in js["data"]) categoriesList.add(data["name"]);
      setState(() {});
    }
  }

  loadLocation() async {
    final Response = await get(Uri.parse(baseUrl + "locations"), headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
      "Vary": "Accept"
    });

    locationList.clear();
    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      fullLocation = js;
      for (var data in js) locationList.add(data["name"]);
      setState(() {});
    }
  }

  List jobList = [];
  ValueNotifier notifier = ValueNotifier(10);

  startLister() {
    notifier.addListener(() {
      loadJobList();
    });
  }

  loadJobList() async {
    final Response = await get(Uri.parse(baseUrl + "jobs"), headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
      "Vary": "Accept"
    });
    print(Response.body);
    jobList.clear();
    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);

      for (var data in js["data"]) jobList.add(data);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCategory();
    loadLocation();
    loadJobList();
    startLister();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: 2.h,),
            SearchBarScreen(
              data: jobList,
              notifier: notifier,
            ),
            SizedBox(height: 1.h),

            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var data in jobList)
                    homecard(
                      jobData: data,
                    ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
