import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/coustemtexfield.dart';
import 'package:chat_app/pages/chat.dart';

class signup extends StatefulWidget{
  signup();
  static String id='regester';
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
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
        appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
        backgroundColor:KprimaryColor,
        body:
        Form(
          key: formkey,
          child: ListView(

            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(50, 60, 40, 0),
                child: Column(
                  children: [
                    Image.asset('assets/images/scholar.png',
                      //width: 150,height: 120,
                    ),
                    const Text('Scholer Chat',style: TextStyle(color: Colors.white,fontSize: 30,fontFamily: 'Schyler'),)
                  ],
                ),
              ),
              const SizedBox(height: 80,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Sign UP',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 25,),
                  catxfd('Email',false,(data){
                    email=data;
                  }),const SizedBox(height: 12,),
                  catxfd('Password',true,(data){
                    password=data;
                  })
                ],
              ),const SizedBox(height: 27
                ,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),

                  child: SizedBox(height: 60,
                    child: ElevatedButton(
                        style:const ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.white)),
                        onPressed: () async{

                       if (formkey.currentState!.validate()) {
                         isloading=true;
                         setState(() {

                         });
                         try{  await registerUser();
                           Navigator.pushNamed(context,chat.id);
                         buildShowSnackBar(context,'Restring Success');
                         }
                         on FirebaseAuthException catch(e){
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

                             if (e.code case "email-already-in-use") {
                               buildShowSnackBar(context,'The provider has already been linked to the user.');


                             } else if (e.code case "weak-password") {
                               buildShowSnackBar(context,'weak password');

                             } else if (e.code case "invalid-credential") {
                               buildShowSnackBar(context,'The provider\'s credential is not valid.');
                             }
                         }
                         isloading=false;
                         setState(() {

                         });
                         //buildShowSnackBar(context,'Restring Success');
                       }

                       else{

                       }

                    },
                        child: const Text('Sign Up',style: TextStyle(color: Colors.black,fontSize: 16),)
                    ),
                  )
              ),
              const SizedBox(height: 18,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Text('Don\'t Have account? ',style: TextStyle(color: Colors.white,fontSize: 16)),
                  //TextButton(onPressed: (){}, child: Text('Sign Up',style: TextStyle(color: Color(0xffc7ede6),fontSize: 20))),
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

  Future<void> registerUser() async {
    UserCredential user=
                     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
  }
}