import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:jobjetadmin/Screens/HomeScreen/HomeScreen.dart';
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
                color: Color(0xff1F41FF),
                fontSize: 25.sp,
                fontWeight: FontWeight.w600),
          ),
          Container(
              alignment: Alignment.center,
              // height: 6.8.h,
              width: 62.w,
              child: Text(
                "Welcome back you’ve been missed!",
                style: GoogleFonts.poppins(
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
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
          SizedBox(
            height: 2.h,
          ),
          if (false)
            Row(
              children: [
                Expanded(child: Container()),
                Text(
                  "Forgot your password?",
                  style: GoogleFonts.poppins(
                      color: Color(0xff1F41BB),
                      fontWeight: FontWeight.w600,
                      fontSize: 11.6.sp),
                ),
                SizedBox(
                  width: 3.5.w,
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
                color: const Color.fromARGB(255, 65, 33, 243),
              ),
              child: (loading)
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white, size: 24)
                  : Text("Sign up",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.2.sp)),
            ),
          )
        ]),
      )),
    );
  }
}
