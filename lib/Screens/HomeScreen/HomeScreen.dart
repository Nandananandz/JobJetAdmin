import 'package:flutter/material.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeCard.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeIntro.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/Searchbar.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child:
            Column(
                children: [
                  // SizedBox(height: 2.h,),
                  SearchBarScreen(),
                  SizedBox(height:1.h),
                  HomeIntroScreen(),
                   SizedBox(height:1.h),
                  homecard(),
                ],
              )
        ),
      ),
    ); 
    
  }
}