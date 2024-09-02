import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:jobjetadmin/Screens/HomeScreen/service/Controller.dart';
import 'package:jobjetadmin/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class DeletePostPopUp extends StatefulWidget {
  var jobData;
  DeletePostPopUp({super.key, required this.jobData});

  @override
  State<DeletePostPopUp> createState() => _DeletePostPopUpState();
}

class _DeletePostPopUpState extends State<DeletePostPopUp> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 91.w,
      height: 36.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            top: 10,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                  backgroundColor: Color(0xffE8ECFF), child: Icon(Icons.close)),
            ),
          ),
          Positioned(
              //  width: 27.w,
              top: 3.7.h,
              left: 31.57.w,
              right: 31.57.w,
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/logout_pop.png"))),
          Positioned(
              left: 10,
              right: 10,
              top: 19.76.h,
              child: Text(
                "Are you sure to delete ?",
                style: GoogleFonts.poppins(
                    fontSize: 12.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              )),
          Positioned(
              left: 10,
              right: 10,
              top: 25.76.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      final Response = await delete(
                          Uri.parse(baseUrl + "jobs/${widget.jobData["id"]}"),
                          headers: AuthHeader);
                      setState(() {
                        loading = false;
                      });
                      if (Response.statusCode == 200) {
                        Fluttertoast.showToast(
                            msg: "Post deleted successfully");
                        JobController ctrl = Get.put(JobController());
                        ctrl.JobList.remove(widget.jobData);
                        ctrl.update();
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                            msg: json.decode(Response.body)["message"]);
                      }
                    },
                    child: Container(
                      width: 28.89.w,
                      height: 5.7.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Color(0xff1F41BA))),
                      child: (loading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.black54, size: 25)
                          : Text(
                              "Yes",
                              style: GoogleFonts.poppins(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 28.89.w,
                      height: 5.7.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff1F41BA),
                          border: Border.all(color: Color(0xff1F41BA))),
                      child: Text(
                        "No",
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
