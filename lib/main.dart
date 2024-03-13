import 'package:flutter/material.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeCard.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/HomeIntro.dart';
import 'package:jobjetadmin/Screens/HomeScreen/Components/Searchbar.dart';
import 'package:jobjetadmin/Screens/HomeScreen/HomeScreen.dart';

import 'package:jobjetadmin/Screens/HomeScreen/Views/components/JobAddCard.dart';

import 'package:jobjetadmin/Screens/LoginScreen/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

String baseUrl = "https://jobhunter.site/api/";
double width = 4.14;
double height = 8.9;
double fontsize = 1.2;
String? login;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();

  token = pref.getString("TOKEN");

  login = pref.getString("STATUS");
  runApp(JobJetAdmin());
}

class JobJetAdmin extends StatelessWidget {
  const JobJetAdmin({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, Orientation, DeviceType) {
      return MaterialApp(
        home: (login == "IN") ? HomeScreen() : LoginScreen(),
      );
    });
  }
}
