import 'package:chat_app/constants.dart';
import 'package:chat_app/models/modelmessage.dart';
import 'package:flutter/material.dart';

class chatbubble extends StatelessWidget {
  const chatbubble({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        //alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16),

        decoration: const BoxDecoration(color: KprimaryColor,borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight:Radius.circular(25) ,bottomRight: Radius.circular(25))),
        child: const Text('iam new user',style: TextStyle(color: Colors.white),),),
    );
  }
}