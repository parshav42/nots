import 'dart:math';

import 'package:flutter/material.dart';
import 'util/routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';



class Loginpage extends StatefulWidget{
  
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
   final _formKey = GlobalKey<FormState>();
  String name="";
  String email = "";
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
        Text('Welcome $name',
        style: TextStyle( fontSize: 24,fontWeight: FontWeight.bold),) 
        ,SizedBox(height: 20,), 
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
          child: Form(
            key: _formKey, // 🔹 Attach the form key here
            child: Column( 
              children: [
            SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
             
              decoration: InputDecoration(
                hintText: 'Enter Email',
                labelText: 'Email ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email cannot be empty";
                }
                else {
                  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                    return "Enter a valid email address";
                  }
                }
                return null;
              },
            ),
            
            SizedBox(height: 20,),
            TextFormField(
              obscureText: true ,
              decoration: InputDecoration(
                hintText: 'Enter Password',
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password cannot be empty";
                } else {
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                }
                return null;
              },
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
            if(_formKey.currentState!.validate()){
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email, // Replace with the actual email input
                  password: password,
                );Navigator.pushNamed(context, MyRoutes.notes);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No user found with this email")),
      );
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incorrect password")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    }
              } catch (e) {
                print("Error initializing Firebase: $e");
              }
              name = "User"; // You can replace this with actual user data after login
              // Perform login action
              // For example, you can navigate to another page or show a success message
              Navigator.pushNamed(context, MyRoutes.notes);
            }
  
            if (_formKey.currentState!.validate()){
           Navigator.pushNamed(context, MyRoutes.notes);
            }
          }
        ),
        
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.register);
          },
          child: Text("New User? Register here", style: TextStyle(color: Colors.blue)),
        )
        ]
        
      ),
    )
  );
  
  
  } 
}
