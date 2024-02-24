import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobjetadmin/main.dart';
import 'package:sizer/sizer.dart';

class JobAddScreen extends StatelessWidget {
  const JobAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
        
              SizedBox(height: 5.h),
              Row(
                children: [
                  SizedBox(width: 2.w,),
                  InkWell(
                    onTap: () { 
                      Navigator.pop(context);
                     },
                    child: Icon(Icons.arrow_back_ios_new_rounded,size: 2.h,color: Color(0xff343434),),
                  ),
                    SizedBox(width: 2.w,),
                  Text('Add New Job',
                  style: GoogleFonts.poppins(
                    fontSize: 16.66.sp,
                    fontWeight:FontWeight.w600,
                    color: Color(0xff343434)
                    ),
                    ),
                ],
              ),
                 SizedBox(height: 3.93.h),
        
             
              _textfield('Job Heading'),
        
        
              _textbox('Location'),
              
        
              _textfield('Post Content'),
        
             
              _textfield('Upload here'),
        
             
              // _textbox('Current Job Tittle'),
        
             
              // _textfield('Resume Link'),
              
              
              SizedBox(height: 2.h),
                Container(
                  margin: EdgeInsets.only(left: 8.w),
                  child: Text('Additional Features',
                    style: GoogleFonts.poppins(
                      fontSize: 11.66.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),
                    ),
                ),
                SizedBox(height: 4.h,),
                  _textbox("Experience"),
                        _textfield("Salary"),
                  _textbox("Joining Date"),
                  SizedBox(height: 3.h,),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 5.h,
                  width: 79.w,
                  decoration: BoxDecoration(
                    color: Color(0xFF1F41BA),
                    borderRadius:BorderRadius.circular(5.61.h),
                  ),
                  child: Text('Submit Post',
                  style: GoogleFonts.poppins(
                    fontSize: 11.66.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF)
                  ),
                  ),
                ),
              ),
             SizedBox(height: 3.h,),
         
            ],
          ),
        ),
      ),
    );
  }
}


 _textfield(String text) {
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
            alignment: Alignment.centerLeft,
                height: 4.94.h,
                width: 84.78.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFCBCBCB)),
                  borderRadius: BorderRadius.circular(15),
                  ),
    
                child:TextFormField(
                  decoration:InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(2.89.w, 1.34.h, 2.89.w, 2.1.h)
                  ),
                  style: GoogleFonts.poppins(
                    color: Color(0xFF1F41BA),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600
                  ),
    
    
                ),
              ),
               SizedBox(height: 1.68.h),
        ],
      ),
    ); 
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
  