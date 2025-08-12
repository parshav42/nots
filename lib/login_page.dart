import 'package:flutter/material.dart';



class Loginpage extends StatelessWidget{
@override 
Widget build(BuildContext context){
return Material(
  color: Colors.white,
  child:SingleChildScrollView(
    child: Column(
    
      children:[
      Image.asset('assets/img/login.png' ,fit: BoxFit.cover,),
      SizedBox(height: 20,),
      Text('Welcome',
      style: TextStyle( fontSize: 24,fontWeight: FontWeight.bold),) 
      ,SizedBox(height: 20,), 
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
        child: Column( 
          children: [TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter Username',
            labelText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          
        
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
        )],
        ),
      )
      ,SizedBox(height: 20,),
      ElevatedButton(
        child: Text("Login"),
        style: TextButton.styleFrom(minimumSize: Size(150, 40)),
        onPressed: () {
          print("Login button pressed");
        }
      )
      ] 
      
    ),
  )
);  
}
}