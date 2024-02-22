import 'dart:html';

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child:Scaffold(
        body:Column(
          children:[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Admin Login",style: TextStyle(color: const Color.fromARGB(255, 65, 33, 243),fontSize: 23,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 200,
                child: Text("Welcome back you've been missed!",style: TextStyle(fontSize:15,fontWeight:FontWeight.bold ),)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                width: 200,
                child: TextField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.blue
                    )
                    ),  
                    filled: true,
                    fillColor: Color.fromARGB(255, 223, 218, 218),          
                  hintText: "Email",
                  hintStyle: TextStyle(fontSize: 13)
                ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                width: 200,
                
                child: TextField(
                   textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.blue
                    )
                    ),
                     
                    filled: true,
                    fillColor:  Color.fromARGB(255, 223, 218, 218),  
                  hintText: "Password",
                   hintStyle: TextStyle(fontSize: 13)
                ),
                ),
              ),
            ),
            Container(
              height: 30,
              width:200,
              alignment: Alignment.bottomRight,
              child: Text("Forgot your password?",style: TextStyle(color: const Color.fromARGB(255, 65, 33, 243),fontWeight: FontWeight.bold,fontSize: 12),) ,
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 65, 33, 243),
                        ),
                        child: Text("Sign up",style:TextStyle(color: Colors.white)  ),
                      
              ))
          ]
        )
      )
    );
  }
}

