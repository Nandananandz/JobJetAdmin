import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Views/components/JobAddCard.dart';
import 'package:sizer/sizer.dart';

class SearchBarScreen extends StatelessWidget {
  var data;
  ValueNotifier notifier;
  SearchBarScreen({super.key, required this.data, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: 8.5.h,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 5.2.w),
                child: Text(
                  "Added ${data.length} Jobs",
                  style: GoogleFonts.poppins(
                      color: Color(0xff1F41FF),
                      fontSize: 13.3.sp,
                      fontWeight: FontWeight.w600),
                )),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => JobAddScreen(notifier: notifier,)));
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: 3.3.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.black,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "Add New Job",
                        style: GoogleFonts.poppins(
                            fontSize: 8.3.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.add,
                        size: 2.w,
                        color: Colors.white,
                      )
                    ],
                  )),
            ),
            SizedBox(
              width: 5.w,
              height: 15.w,
            )
          ],
        ),
      ),
    );
  }
}
