import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class JobDropContainer extends StatelessWidget {
  const JobDropContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
 _textbox(String text) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(text,
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600
              ),
              ),
              SizedBox(height: 0.89.h),
          Container(
                alignment: Alignment.centerRight,
               height: 4.94.h,
                width: 84.78.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFCBCBCB)),
                  borderRadius: BorderRadius.circular(15),
                  ),
                child: DropdownButton(
                  items:null, onChanged: null)
                ),
                 SizedBox(height: 1.68.h),
        ],
      ),
    );
    
  }