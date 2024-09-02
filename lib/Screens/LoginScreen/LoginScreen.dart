import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:jobjetadmin/FogotPasswordPopUp.dart';
import 'package:jobjetadmin/Screens/HomeScreen/HomeScreen.dart';
import 'package:jobjetadmin/Screens/LoginScreen/ForgotPassword.dart';
import 'package:jobjetadmin/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

String? token;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 17.h,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
                width: 6.2.h,
                height: 6.2.h,
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/logo.png"))),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Admin Login",
            style: GoogleFonts.poppins(
                color: Color(0xff1F41BB),
                fontSize: 24.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.center,
              // height: 6.8.h,
              width: 70.w,
              child: Text(
                "Welcome back you’ve been missed!",
                style: GoogleFonts.poppins(
                    fontSize: 15.sp, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
            width: 86.w,
            height: 7.1.h,
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: ("Email"),
                filled: true,
                fillColor: Color(0xffF1F4FF),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            width: 86.w,
            height: 8.1.h,
            child: TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: ("Password"),
                filled: true,
                fillColor: Color(0xffF1F4FF),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => Container(
                          alignment: Alignment.center,
                          child: Material(
                              color: Colors.transparent,
                              child: FogotPasswordPopUp())));
                },
                child: Text(
                  "Forgot your password?",
                  style: GoogleFonts.poppins(
                      color: Color(0xff1F41BB),
                      fontWeight: FontWeight.w600,
                      fontSize: 10.6.sp),
                ),
              ),
              SizedBox(
                width: 4.2.w,
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          InkWell(
            onTap: () async {
              loading = true;

              setState(() {});
              final Response = await post(Uri.parse(baseUrl + "auth/login"),
                  body: {
                    "email": emailController.text,
                    "password": passwordController.text
                  });
              loading = false;
              setState(() {});
              print(Response.statusCode);
              print(Response.body);
              if (Response.statusCode == 200) {
                print(Response.statusCode);
                var data = json.decode(Response.body);
                // Fluttertoast.showToast(msg: data["message"]);

                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("STATUS", "IN");

                pref.setString("TOKEN", data["token"]);

                token = data["token"];
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              } else {
                var data = json.decode(Response.body);
                Fluttertoast.showToast(msg: data["message"]);
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: 86.2.w,
              height: 6.7.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFF41F41BB),
              ),
              child: (loading)
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white, size: 24)
                  : Text("Sign in",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.2.sp)),
            ),
          )
        ]),
      )),
    );
  }
}
