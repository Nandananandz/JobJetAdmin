import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobjetadmin/Screens/HomeScreen/HomeScreen.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Views/components/deletePostPopUp.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Views/components/jobEditCard.dart';
import 'package:jobjetadmin/Screens/HomeScreen/service/Controller.dart';
import 'package:lit_relative_date_time/controller/relative_date_format.dart';
import 'package:lit_relative_date_time/model/relative_date_time.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

class homecard extends StatelessWidget {
  var jobData;
  homecard({super.key, required this.jobData});

  JobController ctrl = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(jobData);
      },
      child: Container(
        padding: EdgeInsets.only(left: 3.4.w, right: 3.4.w),
        // height: 62.98.h,
        width: 99.27.w,
        color: Color(0xFFFFFFFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Row(
              children: [
                SizedBox(
                  height: 12.36.w,
                  width: 12.36.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child:
                        Image.network(jobData["categories"][0]["image"]["url"]),
                  ),
                ),
                SizedBox(
                  width: 2.89.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobData["job_title"].toString(),
                        style: GoogleFonts.nunitoSans(
                          fontSize: 11.66.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Posted on : ${ctrl.releativeTime(jobData["created_at"], context)}',
                            style: GoogleFonts.nunitoSans(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(0, 0, 0, 80)),
                          ),
                          SizedBox(
                            width: 3.86.w,
                          ),
                          Icon(
                            Icons.location_on_rounded,
                            color: Color(0xFF1F41BA),
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              ctrl.idToLocation(jobData["location_id"]),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(0, 0, 0, 80)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                PopupMenuButton(
                    color: Colors.white,
                    icon: Icon(Icons.more_vert),
                    position: PopupMenuPosition.under,
                    onSelected: (value) {
                      if (value == 1) {
                        showDialog(
                            context: context,
                            builder: (ctx) => Container(
                                alignment: Alignment.center,
                                child: Material(
                                    color: Colors.transparent,
                                    child: DeletePostPopUp(
                                      jobData: jobData,
                                    ))));
                      } else {
                        Get.to(() => JobEditScreen(jobData: jobData),
                            transition: Transition.rightToLeft);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text("Edit"),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text("Delete"),
                        ),
                      ];
                    })
              ],
            ),
            SizedBox(
              height: 2.35.h,
            ),
            ReadMoreText(
              jobData["content"].toString(),
              trimLines: 4,
              colorClickableText: Color(0xFF000000),
              trimMode: TrimMode.Line,
              trimCollapsedText: '...see more',
              trimExpandedText: '',
              moreStyle: GoogleFonts.nunitoSans(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(0, 0, 0, 0.8),
              ),
              lessStyle: GoogleFonts.nunitoSans(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(0, 0, 0, 0.8),
              ),
              style: GoogleFonts.nunitoSans(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(0, 0, 0, 0.8)),
            ),
            SizedBox(
              height: 10,
            ),
            if (jobData["image"] != null)
              CarouselSlider(
                options: CarouselOptions(viewportFraction: 1, autoPlay: true),
                items: [
                  for (var data in jobData["image"])
                    Container(
                      height: 41.46.h,
                      width: 99.27.w,
                      child: Image.network(
                        data["original"],
                        fit: BoxFit.fill,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
