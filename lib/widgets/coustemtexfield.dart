//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class catxfd extends StatelessWidget{

    catxfd(this.hint,this.scure,this.onchange);
  String? hint;
  bool scure;
  Function(String) ?onchange;
  @override
  Widget build(BuildContext context) {
   return  TextFormField(
     validator: (data){
       if(data!.isEmpty){
         return 'field is required';
       }

     },
     onChanged: onchange,
     obscureText: scure,
     decoration: InputDecoration(
       hintText: hint,
       hintStyle: TextStyle(
           fontSize: 18,color: Colors.white),
       enabledBorder: OutlineInputBorder(

           borderRadius: BorderRadius.circular(12),
           borderSide: BorderSide(
               color:Colors.white)),
       border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(12),
           borderSide: BorderSide(
               color:Colors.white))
   ),);
  }

}