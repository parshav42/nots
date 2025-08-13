import 'dart:math';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'util/routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';




class Loginpage extends StatefulWidget{
    const Loginpage({Key? key}) : super(key: key);
  
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
   
  final TextEditingController _emailcontroller=TextEditingController();
  final TextEditingController _passwordcontroller=TextEditingController();
  String email = "parshav@gmail.com";
  String password = "";
@override 
Widget build(BuildContext context){
return Scaffold(
  
    backgroundColor: Colors.white,
    body:SingleChildScrollView(
      child: Column(
      
        children:[
        Image.asset('assets/img/login.png' ,fit: BoxFit.fill,),
        SizedBox(height: 5,),
        Text('Welcome Back',
        style: TextStyle( fontSize: 24,fontWeight: FontWeight.bold),) 
        ,SizedBox(height: 20,), 
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
          child: Form(
          
            child: Column( 
              children: [
            SizedBox(height: 20,),
            TextFormField(
         
              keyboardType: TextInputType.emailAddress,
              controller: _emailcontroller,
              
              decoration: InputDecoration(
                hintText: 'Enter Email',
                labelText: 'Email ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
             
            ),
            
            SizedBox(height: 20,),
            TextFormField(
              obscureText: true ,
              controller: _passwordcontroller,
              decoration: InputDecoration(
                hintText: 'Enter Password',
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              
            )],
            ),
          ),
        )
        ,SizedBox(height: 20,),
        ElevatedButton(
          child: Text("Login"
          ,),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,),
          
          
          onPressed: () async{
            final message = await Auth().login(
              email: _emailcontroller.text,
              password: _passwordcontroller.text,
            );
            if (message == 'Success') {
              Navigator.pushNamed(context, MyRoutes.notes);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message ?? 'Login failed'))
              );
            }

          }
        ),
TextButton(
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.register);
          },
          child: Text("New User? Register here", style: TextStyle(color: Colors.blue)),
        )
        
        
        ],
      ),
    ),
);
}

}

         

  
    
  
