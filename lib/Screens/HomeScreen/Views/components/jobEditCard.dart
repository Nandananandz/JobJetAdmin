import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jobjetadmin/Screens/HomeScreen/HomeScreen.dart';
import 'package:jobjetadmin/Screens/HomeScreen/service/Controller.dart';
import 'package:jobjetadmin/Screens/LoginScreen/LoginScreen.dart';
import 'package:jobjetadmin/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sizer/sizer.dart';

class JobEditScreen extends StatefulWidget {
  //ValueNotifier notifier;
  var jobData;
  JobEditScreen({super.key, required this.jobData});

  @override
  State<JobEditScreen> createState() => _JobEditScreenState(jobData: jobData);
}

class _JobEditScreenState extends State<JobEditScreen> {
  var jobData;
  _JobEditScreenState({required this.jobData});

  List imageList = [];

  @override
  void initState() {
    // TODO: implement initState

    JobHeading.text = jobData["job_title"] ?? "";
    location.text = ctrl.idToLocation(jobData["location_id"]);
    category.text =
        jobData["categories"].map((e) => e["name"]).toList().join(",");
    content.text = jobData["content"] ?? "";
    email.text = jobData["email"] ?? "";
    phoneNumber.text = jobData["phone"] ?? "";
    experience.text = jobData["experience_required"] ?? "";
    salary.text = jobData["salary"] ?? "";
    joiningTime.text = jobData["joining_time"] ?? "";

    ///  imageList = [...jobData["image"]] ?? [];
    //print(imageList);
    super.initState();
  }

  TextEditingController JobHeading = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController joiningTime = TextEditingController();
  ScrollController scroll = ScrollController();
  List<File> imageFile = [];
  bool loading = false;
  JobController ctrl = Get.put(JobController());
  bool optionalExpand = false;
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
                  'Update  Job',
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
                controller: scroll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // _textbox("Category", ctrl.jobCategory, category),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category",
                          style: GoogleFonts.poppins(
                              fontSize: 10.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 0.89.h),
                        Container(
                            alignment: Alignment.centerLeft,
                            height: 4.94.h,
                            width: 84.78.w,
                            // padding: EdgeInsets.symmetric(horizontal: 4.2.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFCBCBCB)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: DropDownMultiSelect(
                              childBuilder: (selectedValues) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                child: Text(
                                  selectedValues.join(", "),
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF1F41BA),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              onChanged: (x) {
                                setState(() {
                                  category.text = x.join(",");
                                });
                              },
                              options: ctrl.jobCategory,
                              selectedValues: (category.text.isEmpty)
                                  ? []
                                  : category.text.split(","),
                              whenEmpty: 'Select category',
                            )),
                        SizedBox(height: 1.68.h),
                      ],
                    ),
                    _textfield("Job Heading", JobHeading),
                    _textbox("Locations", ctrl.locationNameList, location),
                    _textfield("Content", content,
                        height: 30,
                        pad: true,
                        keytype: TextInputType.multiline,
                        ver: TextAlignVertical.top),
                    _textfield("Email", email),
                    _textfield("Phone", phoneNumber,
                        keytype: TextInputType.number),
                    if (false)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () async {
                            final img = await ImagePicker.platform
                                .getImageFromSource(
                                    source: ImageSource.gallery);

                            if (img != null) {
                              setState(() {
                                imageFile.add(File(img.path));
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
                    if (false)
                      if (imageFile.isNotEmpty || imageList.isNotEmpty)
                        CarouselSlider(
                            items: [
                              for (File data in imageFile)
                                Container(
                                    height: 38.46.h,
                                    width: 100.w,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFFCBCBCB)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 38.46.h,
                                          width: 100.w,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.file(
                                                data!,
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                        // Positioned(
                                        //     top: 10,
                                        //     right: 10,
                                        //     child: InkWell(
                                        //       onTap: () {
                                        //         imageFile.remove(data);
                                        //         setState(() {});
                                        //       },
                                        //       child: CircleAvatar(
                                        //         backgroundColor: Colors.white60,
                                        //         child: Icon(Icons.delete),
                                        //       ),
                                        //     ))
                                      ],
                                    )),
                              for (var data in imageList)
                                Container(
                                    height: 38.46.h,
                                    width: 100.w,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFFCBCBCB)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 38.46.h,
                                          width: 100.w,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                data!["original"],
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                        Positioned(
                                            top: 10,
                                            right: 10,
                                            child: InkWell(
                                              onTap: () {
                                                imageList.remove(data);
                                                setState(() {});
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white60,
                                                child: Icon(Icons.delete),
                                              ),
                                            ))
                                      ],
                                    )),
                            ],
                            options: CarouselOptions(
                              height: 38.46.h,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            )),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Additional features",
                              style: GoogleFonts.poppins(
                                  fontSize: 13.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                optionalExpand = !optionalExpand;
                              });

                              await Future.delayed(Duration(milliseconds: 100));
                              scroll.animateTo(
                                scroll.position.maxScrollExtent,
                                duration: Duration(
                                    milliseconds:
                                        500), // Adjust the duration as needed
                                curve: Curves.easeOut,
                              );
                            },
                            child: RotatedBox(
                                quarterTurns: (optionalExpand) ? 3 : 2,
                                child: Icon(Icons.arrow_back_ios_new_outlined)),
                          ),
                        ],
                      ),
                    ),
                    if (optionalExpand)
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          _textfield("Experience", experience,
                              keytype: TextInputType.number),
                          _textfield("Salary", salary,
                              keytype: TextInputType.number),
                          _textbox(
                              "Date of Joining",
                              [
                                "Immediate",
                                "Within 1 week",
                                "Within 2 weeks",
                                "Within 1 month",
                                "Within 2 months",
                                "Within 6 months"
                              ],
                              joiningTime),
                        ],
                      )
                  ],
                ),
              ),
            )),
            Center(
              child: InkWell(
                onTap: () async {
                  if (JobHeading.text.isNotEmpty &&
                      category.text.isNotEmpty &&
                      location.text.isNotEmpty &&
                      content.text.isNotEmpty &&
                      email.text.isNotEmpty &&
                      phoneNumber.text.isNotEmpty) {
                    setState(() {
                      loading = true;
                    });
                    var request = http.MultipartRequest(
                        'POST', Uri.parse(baseUrl + 'file-upload'));
                    if (imageFile.isNotEmpty)
                      for (var data in imageFile)
                        request.files.add(await http.MultipartFile.fromPath(
                            'attachment[]', data!.path));
                    request.headers.addAll({
                      'Content-Type': 'application/json',
                      "Authorization": "Bearer $token",
                      "Vary": "Accept"
                    });

                    http.StreamedResponse response = await request.send();
                    print(response.statusCode);

                    if (response.statusCode == 200 ||
                        response.statusCode == 302) {
                      final contentupload = await http.patch(
                          Uri.parse(baseUrl + "jobs/${jobData["id"]}"),
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
                            "categories": [
                              for (var data in category.text.split(","))
                                categoryToID(data)
                            ],
                            "status": "opened",
                            if (imageFile.isNotEmpty || imageList.isNotEmpty)
                              "image": [
                                if (imageFile.isNotEmpty)
                                  for (var data in json.decode(
                                      await response.stream.bytesToString()))
                                    data,
                                for (var data in imageList) data
                              ]
                            else
                              "image": [],
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
                        //  widget.notifier.value++;
                        JobController ctrl = Get.put(JobController());
                        ctrl.fetchJobs();
                      } else {
                        setState(() {
                          loading = false;
                        });
                        var data = json.decode(contentupload.body);
                        Fluttertoast.showToast(msg: data["message"].toString());
                      }
                    }
                  } else {
                    Fluttertoast.showToast(msg: "Please fill required field");
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
      {double height = 4.94,
      TextInputType keytype = TextInputType.name,
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
          width: 84.78.w,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFCBCBCB)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            controller: value,
            keyboardType: keytype,
            textAlignVertical: ver, // TextAlignVertical.center,
            expands: true,
            maxLines: null,
            decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                isCollapsed: true,
                contentPadding: (pad)
                    ? EdgeInsets.fromLTRB(2.89.w, 2.89.w, 2.89.w, 0)
                    : EdgeInsets.fromLTRB(2.89.w, 0, 2.89.w, 0)),
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
    for (var data in ctrl.fullLocation) {
      print(data);
      if (data["name"] == location) {
        return data["id"].toString();
      }
    }
    return "1";
  }

  String categoryToID(String category) {
    for (var data in ctrl.fullCategory) {
      if (data["name"] == category) {
        return data["id"].toString();
      }
    }
    return "1";
  }
}
