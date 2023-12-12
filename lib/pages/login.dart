
import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chat_app/pages/chat.dart';
import '../widgets/coustemtexfield.dart';

class login extends StatefulWidget{
  login();
static String id='login';
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String? email;

  String ?password;
  GlobalKey<FormState> formkey=GlobalKey();

  bool isloading=false;

  @override
  Widget build(BuildContext context) {
   return ModalProgressHUD(
     inAsyncCall: isloading,
     child: Scaffold(
resizeToAvoidBottomInset: false,
       backgroundColor: KprimaryColor,
       body:Form(
         key: formkey,
         child: ListView(

           children: [

             Padding(
               padding: const EdgeInsets.fromLTRB(50, 110, 40, 0),
               child: Column(
                 children: [
                   Image.asset('assets/images/scholar.png',
                     //width: 150,height: 120,
                   ),
                   Text('Scholer Chat',style: TextStyle(color: Colors.white,fontSize: 30,fontFamily: 'Schyler'),)
                 ],
               ),
             ),
             SizedBox(height: 80,),
             Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),
                 SizedBox(height: 25,),
                 catxfd('Email',false,(data){ email=data;}),SizedBox(height: 12,),
                 catxfd('Password',true,(data){password=data;})
               ],
             ),SizedBox(height: 27
               ,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 30.0),
               child: SizedBox(
                   height:60,
                   child: ElevatedButton(
                       style:ButtonStyle(
                           backgroundColor:
                           MaterialStatePropertyAll<Color>(Colors.white)),onPressed: ()async{

                     if (formkey.currentState!.validate()) {
                       isloading=true;
                       setState(() {

                       });
                       try{  await loginUser();
                       buildShowSnackBar(context,'login Success');
                       Navigator.pushNamed(context,chat.id);
                       }
                       on FirebaseAuthException catch(e){
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

                         if (e.code == "user-not-found") {
                           buildShowSnackBar(context,'No user found for that email.');


                         } else if (e.code == "wrong-password") {
                           buildShowSnackBar(context,'Wrong password provided for that user.');

                         }
                       }catch(e){print(e);}
                       isloading=false;
                       setState(() {

                       });
                       //buildShowSnackBar(context,'Restring Success');
                     }

                     else{

                     }

                   },
                       child: Text('Sign In',style: TextStyle(color: Colors.black,fontSize: 16),))),
             ),
             SizedBox(height: 18,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text('Don\'t Have account? ',style: TextStyle(color: Colors.white,fontSize: 16)),
                 TextButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                     return signup();
                   })

                   );
                 }, child: Text('Sign Up',style: TextStyle(color: Color(0xffc7ede6),fontSize: 20))),
               ],
             )
             //TextButton(onPressed: (){}, child: Text('Sign In',style: TextStyle(backgroundColor: Colors.white),))
           ],),
       ),
     ),
   );
  }
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildShowSnackBar
      (BuildContext context,String text) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: buildText(text)));

  Text buildText(text) => Text(text);
  Future<void> loginUser() async {
    UserCredential user=
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
  }
}
