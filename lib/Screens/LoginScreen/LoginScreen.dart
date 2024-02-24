

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeCard.dart';
import 'package:jobjetadmin/Screens/HomeScreen/HomeScreen.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              SizedBox(height: 17.h,),
             Align(
              alignment: Alignment.center,
               child: SizedBox(
                width: 6.2.h,
                height: 6.2.h,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/logo.png"))),
             ),
             SizedBox(height: 2.h,),
              Text("Admin Login",style: GoogleFonts.poppins(color: Color(0xff1F41FF),fontSize: 25.sp,fontWeight: FontWeight.w700),),
              Container(
                alignment: Alignment.center,
                height: 6.8.h,
                width: 62.w,
                child: Text("Welcome back you've been missed!",style: GoogleFonts.poppins(fontSize:16.sp,fontWeight:FontWeight.w600),textAlign: TextAlign.center,)),
              SizedBox(height: 5.h,),
              SizedBox(
                width: 86.w,
                height: 7.1.h,
                child:  TextFormField(
                             
                              keyboardType: TextInputType.emailAddress,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: ("Email"),
                                filled: true,
                                fillColor: Color(0xffF1F4FF),
                               
                               enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.w),
                                borderSide: BorderSide(color: Color(0xff1F41BB).withOpacity(0.9),width: 1.5)
                               )
                               
                               
                              ),
                            ),
              ),
              SizedBox(height: 2.h,),
              SizedBox(
                width: 86.w,
                height: 7.1.h,
                child: TextFormField(
                             
                              keyboardType: TextInputType.emailAddress,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: ("Password"),
                                filled: true,
                                fillColor: Color(0xffF1F4FF),
                               
                               enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.w),
                                borderSide: BorderSide(color: Color(0xffF1F4FF).withOpacity(0.99),width: 1.5)
                               )
                               
                               
                              ),
                            ),
              ),
              SizedBox(height: 4.h,),
             Row(
              children: [
                Expanded(child: Container()),
                Text("Forgot your password?",style: GoogleFonts.poppins(color:Color(0xff1F41BB) ,fontWeight: FontWeight.w600,fontSize: 11.6.sp),)
               ,SizedBox(width: 3.5.w,),
              ],
             ),
             SizedBox(height: 2.h,),
                Container(
                        alignment: Alignment.center,
                        width: 86.2.w,
                        height: 6.7.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 65, 33, 243),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(()=>HomeScreen());
                          },
                          child: Text("Sign up",style:GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16.2.sp)  )
                          ),
                      
                )
            ]
          ),
        )
      ),
    );
  }
}

