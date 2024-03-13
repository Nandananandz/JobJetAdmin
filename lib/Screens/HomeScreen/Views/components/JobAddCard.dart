import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jobjetadmin/Screens/HomeScreen/HomeScreen.dart';
import 'package:jobjetadmin/Screens/LoginScreen/LoginScreen.dart';
import 'package:jobjetadmin/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class JobAddScreen extends StatefulWidget {
  ValueNotifier notifier;
  JobAddScreen({super.key, required this.notifier});

  @override
  State<JobAddScreen> createState() => _JobAddScreenState();
}

class _JobAddScreenState extends State<JobAddScreen> {
  TextEditingController JobHeading = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController joiningTime = TextEditingController();
  File? imageFile;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),
            Row(
              children: [
                SizedBox(
                  width: 2.w,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 6.w,
                    color: Color(0xff343434),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  'Add New Job',
                  style: GoogleFonts.poppins(
                      fontSize: 16.66.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff343434)),
                ),
              ],
            ),
            SizedBox(height: 3.93.h),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(4.2.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _textfield("Job Title", JobHeading),
                    _textbox("Locations", locationList, location),
                    _textfield("Email", email),
                    _textfield("Phone", phoneNumber,
                        keytype: TextInputType.number),
                    _textfield("Experience", experience,
                        keytype: TextInputType.number),
                    _textfield("Salary", salary, keytype: TextInputType.number),
                    _textfield("Date of Joining", joiningTime),
                    _textbox("Category", categoriesList, category),
                    _textfield("Content", content,
                        height: 30, keytype: TextInputType.multiline),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () async {
                          final img = await ImagePicker.platform
                              .getImageFromSource(source: ImageSource.gallery);

                          if (img != null) {
                            setState(() {
                              imageFile = File(img.path);
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.2.w),
                          alignment: Alignment.center,
                          height: 5.h,
                          width: 40.78.w,
                          child: Text(
                            "Upload Image",
                            style: GoogleFonts.poppins(
                                fontSize: 10.sp, fontWeight: FontWeight.w600),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFCBCBCB)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (imageFile != null)
                      Container(
                          height: 38.46.h,
                          width: 100.w,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFCBCBCB)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.fill,
                              )))
                  ],
                ),
              ),
            )),
            Center(
              child: InkWell(
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  var request = http.MultipartRequest(
                      'POST', Uri.parse(baseUrl + 'file-upload'));
                  if (imageFile != null)
                    request.files.add(await http.MultipartFile.fromPath(
                        'attachment[]', imageFile!.path));
                  request.headers.addAll({
                    'Content-Type': 'application/json',
                    "Authorization": "Bearer $token",
                    "Vary": "Accept"
                  });

                  http.StreamedResponse response = await request.send();
                  print(response.statusCode);

                  if (response.statusCode == 200 ||
                      response.statusCode == 302) {
                    final contentupload = await http.post(
                        Uri.parse(baseUrl + "jobs/"),
                        headers: {
                          'Content-Type': 'application/json',
                          "Authorization": "Bearer $token",
                          "Vary": "Accept"
                        },
                        body: json.encode({
                          "job_title": JobHeading.text,
                          "location_id": locationtoID(location
                              .text), // Assuming you have the location_id of the job
                          "content": content.text,
                          "email": email.text,
                          "phone": phoneNumber.text,
                          "categories": [categoryToID(category.text)],
                          "status": "opened",
                          if (imageFile != null)
                            "image": {
                              "url": json.decode(
                                      await response.stream.bytesToString())[0]
                                  ["original"],
                              "alt_text": "Job Image"
                            },
                          "experience_required": experience.text,
                          "salary": salary.text,
                          "joining_time": joiningTime.text,
                          "is_active": true
                        }));
                    print(contentupload.body);
                    print(contentupload.statusCode);
                    setState(() {
                      loading = false;
                    });
                    if (contentupload.statusCode == 200) {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(msg: "Content Uploaded");
                      widget.notifier.value++;
                    } else {
                      setState(() {
                        loading = false;
                      });
                      var data = json.decode(contentupload.body);
                      Fluttertoast.showToast(msg: data["message"].toString());
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 5.h,
                  width: 79.w,
                  decoration: BoxDecoration(
                    color: Color(0xFF1F41BA),
                    borderRadius: BorderRadius.circular(5.61.h),
                  ),
                  child: (loading)
                      ? LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white, size: 24)
                      : Text(
                          'Submit Post',
                          style: GoogleFonts.poppins(
                              fontSize: 11.66.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF)),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }

  _textfield(String text, TextEditingController value,
      {double height = 6.94, TextInputType keytype = TextInputType.name}) {
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
          width: 84.78.w,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFCBCBCB)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            controller: value,
            keyboardType: keytype,
            textAlignVertical: TextAlignVertical.center,
            expands: true,
            maxLines: null,
            decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    EdgeInsets.fromLTRB(2.89.w, 1.34.h, 2.89.w, 2.1.h)),
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

  _textbox(String text, List type, TextEditingController CurrentValue) {
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
            alignment: Alignment.centerLeft,
            height: 4.94.h,
            width: 84.78.w,
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFCBCBCB)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DropdownButton<String>(
                value: CurrentValue.text == "" ? null : CurrentValue.text,
                isExpanded: true,
                underline: Container(),
                items: type
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (value) {
                  CurrentValue.text = value!;
                  setState(() {});
                })),
        SizedBox(height: 1.68.h),
      ],
    );
  }

  String locationtoID(String location) {
    for (var data in fullLocation) {
      print(data);
      if (data["name"] == location) {
        return data["id"].toString();
      }
    }
    return "1";
  }

  String categoryToID(String category) {
    for (var data in fullCategory) {
      if (data["name"] == category) {
        return data["id"].toString();
      }
    }
    return "1";
  }
}
