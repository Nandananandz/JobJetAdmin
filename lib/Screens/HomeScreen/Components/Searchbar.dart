import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Views/components/JobAddCard.dart';
import 'package:sizer/sizer.dart';

class SearchBarScreen extends StatelessWidget {
  const SearchBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Container(
        color: Colors.white,
        height: 14.5.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h,),
             Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 5.w,),
                      Text(
                        'Sort  by :',
                        style: TextStyle(
                          fontSize: 9.0.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                     // SizedBox(width:1.95.w),
                       Text(
                        'Newest Posts',
                        style: TextStyle(
                          fontSize: 9.0.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                        
                      
                      Icon(Icons.keyboard_arrow_down),
                      Expanded(child: Container()),
                       InkWell(
                        onTap: () {
                          Get.to(()=>JobAddScreen());
                        },
                         child: Container(
                          alignment: Alignment.center,
                          width: 22.2.w,
                          height: 3.3.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(13),
                          color: Colors.black,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 1.w,),
                              Text("Add New Job",style: GoogleFonts.poppins(fontSize: 8.3.sp,fontWeight: FontWeight.w400,color: Colors.white),),
                              Icon(Icons.add,size: 2.w,color: Colors.white,)
                            ],
                          )
                                             
                                       ),
                       ),
                SizedBox(width: 2.w,),
                 SizedBox(
                  width: 10.w,
                  height: 7.w,
                  child: Image.asset("assets/sort.png",fit: BoxFit.cover,)),
                      
                   ],),
             SizedBox(height: 0.5.h,),
              Container(
                margin: EdgeInsets.only(left: 5.2.w),
                child: Text("Added 29 Jobs",style: GoogleFonts.poppins(color: Color(0xff1F41FF),fontSize: 13.3.sp,fontWeight: FontWeight.w600),)),
               
      
          ],
        ),
      ),



      )
    
      ,
    );
  }
}