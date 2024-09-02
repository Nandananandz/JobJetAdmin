import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:jobjetadmin/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int state = 1;
  bool loading = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPassowrdController = TextEditingController();
  TextEditingController OtpController = TextEditingController();

  setOtp() async {
    setState(() {
      loading = true;
    });
    final Response = await post(Uri.parse(baseUrl + "auth/send-otp"),
        body: {"mobile": phoneController.text.trim()});
    setState(() {
      loading = false;
    });
    print(Response.body);
    print(Response.statusCode);
    if (Response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'OTP send successfully to +9175xxxxxx6805');
      setState(() {
        state = 1;
      });
    } else {
      var data = json.decode(Response.body);
      Fluttertoast.showToast(msg: data["error"] ?? "unknow error please retry");
    }
  }

  forgotPassword() async {
    setState(() {
      loading = true;
    });
    final Response =
        await post(Uri.parse(baseUrl + "auth/admin/forgot-password"), body: {
      "mobile": phoneController.text.trim(),
      "otp": OtpController.text.trim(),
      "password": passwordController.text.trim(),
      "password_confirmation": cPassowrdController.text.trim()
    });
    setState(() {
      loading = false;
    });
    print(Response.body);
    print(Response.statusCode);

    if (Response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Password changed Successfully");
      Get.back();
    } else {
      var data = json.decode(Response.body);
      Fluttertoast.showToast(msg: data["error"] ?? "unknow error please retry");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    phoneController.text = "+917558056805";
    super.initState();
    setOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      // margin: EdgeInsets.only(
                      //     left: 3.86.w,
                      //     //  bottom: 1.0.h,
                      //     top: 2.23.h,
                      //     right: 1.46.w),
                      alignment: Alignment.center,
                      height: 4.04.h,
                      width: 8.69.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFE8ECFF)),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 1.8.h,
                        color: Color(0xFF121B54),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.0.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "  Forgot",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.66.sp,
                            color: Color(0xff121B54)),
                      ),
                      Text(
                        " Password",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.66.sp,
                            color: Color(0xff28B2FB)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state == 0)
                    _textfield("Enter phone number", phoneController,
                        keytype: TextInputType.phone, height: 6),
                  if (state == 1)
                    Container(
                        width: 100.w,
                        margin: EdgeInsets.symmetric(
                            horizontal: 4.2.w, vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter OTP",
                              style: GoogleFonts.poppins(
                                  fontSize: 10.sp, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 0.89.h),
                            Pinput(
                              controller: OtpController,
                              defaultPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF1F41BA).withOpacity(.1)),
                                textStyle: GoogleFonts.poppins(
                                    color: Color(0xFF1F41BA),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        )),
                  if (state == 1)
                    _textfield("Enter new password", passwordController,
                        height: 6, pad: true),
                  if (state == 1)
                    _textfield("confirm new password", cPassowrdController,
                        pad: true, height: 6)
                ],
              ),
            )),
            InkWell(
              onTap: () {
                if (state == 0) {
                  if (phoneController.text.isNotEmpty) {
                    setOtp();
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please enter valid phone number");
                  }
                } else {
                  if (OtpController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please enter otp");
                  } else if (passwordController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please enter password");
                  } else if (cPassowrdController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please enter confirm passowrd");
                  } else if (cPassowrdController.text !=
                      passwordController.text) {
                    Fluttertoast.showToast(
                        msg: "New password and confirm password are mismatch");
                  } else {
                    forgotPassword();
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 6.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Color(0xFF1F41BA),
                  borderRadius: BorderRadius.circular(2.61.h),
                ),
                child: (loading)
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white, size: 24)
                    : Text(
                        (state == 0) ? "Send OTP" : 'Reset Password',
                        style: GoogleFonts.poppins(
                            fontSize: 11.66.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFFFFFF)),
                      ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

_textfield(String text, TextEditingController value,
    {double height = 4.94,
    TextInputType keytype = TextInputType.name,
    Function? onChange(String val)?,
    bool pad = false,
    TextAlignVertical ver = TextAlignVertical.center}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style:
            GoogleFonts.poppins(fontSize: 10.sp, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 0.89.h),
      Container(
        alignment: Alignment.center,
        height: height.h,
        width: 90.w,
        // padding: EdgeInsets.symmetric(horizontal: 4.2.w),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFCBCBCB)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: value,
          keyboardType: keytype,
          textAlignVertical: ver, // TextAlignVertical.center,
          // expands: true,
          obscureText: pad,
          maxLines: 1,
          onChanged: (value) {
            if (onChange != null) {
              onChange(value);
            }
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              isCollapsed: true,
              hintText: text,
              contentPadding: EdgeInsets.fromLTRB(2.89.w, 0, 2.89.w, 0)),
          style: GoogleFonts.poppins(
              color: Color(0xFF1F41BA),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
      SizedBox(height: 1.68.h),
    ],
  );
}
