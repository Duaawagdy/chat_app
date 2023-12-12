import 'package:chat_app/pages/chat.dart';
import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'widgets/coustemtexfield.dart';
// Import the generated file
import 'firebase_options.dart';
import 'package:chat_app/pages/chat.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        login.id:(context)=>login()
         ,chat.id:(context)=>chat(),
        signup.id:(context)=>signup()
      },
        initialRoute:login.id,
      debugShowCheckedModeBanner: false,
      //home: login()
    );
  }
}
