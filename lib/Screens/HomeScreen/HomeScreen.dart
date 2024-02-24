import 'package:flutter/material.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeCard.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeIntro.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/Searchbar.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Views/components/Bottonbar.dart';
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
              ),
            
              
        ),
        
      ),
        bottomNavigationBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: BottomNavigationBar(
          
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 8.2.w,
                height: 8.2.w,
                child: Image.asset("assets/home.png",width: 11.70.w, height: 5.39.h)),
              label: "Home",
              ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 7.2.w,
                height: 7.2.w,child: Image.asset("assets/book.png",width: 11.70.w, height: 5.39.h)),
               label: "Data",
            ),
            BottomNavigationBarItem(
              icon: SizedBox( width: 7.2.w,
                height: 7.2.w,child: Image.asset("assets/note.png",width: 11.70.w, height: 5.39.h)),
               label: "Wallet",
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                 width: 7.2.w,
                height: 7.2.w,child: Image.asset("assets/profile.png",width: 11.70.w, height: 5.39.h)),
               label: "Profile",
              
            ),
            
          ],
          iconSize:1,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: (value){

            
          },
              ),
        ),
    ); 
  
    
  }
}