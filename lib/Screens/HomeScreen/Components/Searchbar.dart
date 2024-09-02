import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Views/components/AdvanceFilterPage.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Views/components/JobAddCard.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Views/components/logoutPopUp.dart';
import 'package:jobjetadmin/Screens/HomeScreen/service/Controller.dart';
import 'package:sizer/sizer.dart';

class SearchBarScreen extends StatefulWidget {
  var data;

  SearchBarScreen({
    super.key,
    required this.data,
  });

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  JobController ctrl = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: 12.5.h,
        padding: EdgeInsets.symmetric(horizontal: 4.3.w, vertical: 10),
        child: GetBuilder<JobController>(builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sort  by :',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 10.0.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 1.95.w),
                  DropdownButton(
                      value: ctrl.selectedSort,
                      underline: Container(),
                      items: [
                        "All Jobs",
                        "Today",
                        "Yesterday",
                        "Last week",
                        "1 month",
                        "2 months"
                      ]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 10.0.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (ValueKey) {
                        setState(() {
                          ctrl.selectedSort = ValueKey!;
                        });

                        ctrl.fetchJobs(sort: ValueKey!.toLowerCase());
                      }),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobAddScreen(
                                  //   notifier: widget.notifier,
                                  )));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 3.3.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Color(0xff121B54),
                        ),
                        child: Text(
                          "Add New Job +",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 8.3.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    width: 2.w,
                    //  height: 10.w,
                  ),
                  InkWell(
                    onTap: () {
                      // selectedBottomindex = 2;
                      // notifer.value++;
                      Get.to(() => AdvanceFilterPage(),
                          transition: Transition.rightToLeft);
                    },
                    child: Container(
                      height: 4.h,
                      width: 3.h,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        right: 1.2.w,
                      ),
                      child: Image.asset("assets/filter.png"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        // margin: EdgeInsets.only(left: 5.2.w),
                        child: Text(
                      "Added ${ctrl.JobList.length} Jobs",
                      style: GoogleFonts.poppins(
                          color: Color(0xff1F41BB),
                          fontSize: 13.3.sp,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => Container(
                              alignment: Alignment.center,
                              child: Material(
                                  color: Colors.transparent,
                                  child: LogoutAlertDialog())));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 3.3.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff121B54)),
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.white // Color(0xff121B54),
                            ),
                        child: Text(
                          "Logout",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 8.3.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff121B54)),
                        )),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
