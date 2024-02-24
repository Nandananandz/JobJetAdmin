import 'package:flutter/material.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeCard.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeIntro.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/Searchbar.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
          Column(
              children: [
                SizedBox(height: 2.h,),
                SearchBarScreen(),
                SizedBox(height:1.h),
                HomeIntroScreen(),
                 SizedBox(height:1.h),
                homecard(),
              ],
            )
      ),
    ); 
    
  }
}