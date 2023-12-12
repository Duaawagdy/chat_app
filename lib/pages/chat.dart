//import 'dart:html';
import 'package:chat_app/models/modelmessage.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/chatbubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class chat extends StatelessWidget{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  TextEditingController controller=TextEditingController();

  static String id='chatpage';
  @override
  Widget build(BuildContext context) {

   return FutureBuilder<QuerySnapshot>(
       future: messages.get(),
       builder: ( context, snapshot) {

         if(snapshot.hasData){
           List<message>messageslist=[];
               //print(snapshot.data!.docs[0]['text']);
              return Scaffold(
             appBar: AppBar(automaticallyImplyLeading: false,
               title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width:50,child: Image.asset('assets/images/scholar.png')),
            const Text('ScolarChat'),
          ],
        ),centerTitle: true,backgroundColor: KprimaryColor,),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder:
                (context,index){return chatbubble();}),
          ),
          Padding(

            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller:controller ,
              onSubmitted: (date){
                messages.add({'text':date});
                controller.clear();
              },
              decoration: InputDecoration(hintText: 'Send message!',suffixIcon: Icon(Icons.send_sharp,color: KprimaryColor,),border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: KprimaryColor)) ,),),
          )
        ],
      )
  );
}
         else{
           return Text('loading...');
         }
   });
  }
}

