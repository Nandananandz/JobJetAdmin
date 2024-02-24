import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

class HomeIntroScreen extends StatelessWidget {
  const HomeIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:    Container(
          width:100.w ,
              padding: EdgeInsets.all(3.4.w),
                   
                    color: Color(0xFFFFFFFF),
            
              child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h,),
                      Row(
                        children: [
          
                          Container(
                            height: 4.44.h,
                            width: 10.38.w,
                            decoration: BoxDecoration(
                              color:Color(0xFF121B54),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Image.asset('assets/doctor.png',
                            height: 3.18.h,
                            width: 6.85.w,
                            ),
                          ),
                          
                          SizedBox(width: 2.89.w,),
          
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Customers service Executive',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 11.66.sp,
                                fontWeight: FontWeight.w700,
                                
                              ),
                              ),
                              Row(
                                children: [
                                  Text('Posted on : Yesterday',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(0, 0, 0, 80)
                                  ),
                                  ),

                                  SizedBox(width: 3.86.w,),
                          
                                  Icon(Icons.location_on_rounded,color: Color(0xFF1F41BA),size: 12,),
                                  Text('Abudhabi',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(0, 0, 0, 80)
                                  ),
                                  )
                                ],
                              ) 
                            ],
                          ),
                          Expanded(child: Container()),
                          Image.asset("assets/menu.png"),
                          SizedBox(width: 3.w,),

                          ],),
                        SizedBox(height: 2.h,),
                            ReadMoreText('A Software Company in Gulberg Greens Islamabad is looking for a HR Generalist.\n The Human Resource Generalist will run the daily functions the Human Resource [HR] department including hiring and interviewing staff,administering pay,benefits and leave ',
                      trimLines: 3,
                      colorClickableText: Color(0xFF000000),
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'see more',
                      trimExpandedText: '..see less',
                      moreStyle:GoogleFonts.nunitoSans(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                      lessStyle:GoogleFonts.nunitoSans(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                       style: GoogleFonts.nunitoSans(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 0, 0, 0.8)
                      ),
                      ),
                  

                          ],),
                       
                          
                          
               
              ));
      
        
    

    
  
  }
}