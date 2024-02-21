import 'package:flutter/material.dart';
import 'package:jobjetadmin/Screens/LoginScreen/LoginScreen.dart';
import 'package:sizer/sizer.dart';
double width = 4.14;
 double height = 8.9;
 double fontsize = 1.2;
void main() {
  runApp(JobJetAdmin());
}

class JobJetAdmin extends StatelessWidget {
  const JobJetAdmin({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, Orientation ,DeviceType) {
        return MaterialApp(
         
          home: LoginScreen(),
        );
      }
    );
  }
}


