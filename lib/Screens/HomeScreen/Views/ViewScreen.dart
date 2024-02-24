import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Views/components/JobDropCard.dart';
import 'package:sizer/sizer.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
               SizedBox(width: 2.w,),
                  InkWell(
                    onTap: () { 
                      Navigator.pop(context);
                     },
                    child: Icon(Icons.arrow_back_ios_new_rounded,size: 2.h,color: Color(0xff343434),),
                  ),
                    SizedBox(width: 2.w,),
                  Text('Add New Job',
                  style: GoogleFonts.poppins(
                    fontSize: 16.66.sp,
                    fontWeight:FontWeight.w600,
                    color: Color(0xff343434)
                    ),
                    ),

            ],
          ),
          JobDropContainer(),
        ],
      ),
    );
  }
}