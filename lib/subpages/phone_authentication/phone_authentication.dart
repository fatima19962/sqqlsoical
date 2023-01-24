
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqqlsoical/subpages/phone_authentication/phone_verify_screen.dart';


class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          SizedBox(height: 50.0,),
          TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Phone Number"
            ),
          ),
          SizedBox(height: 80.0,),
          ElevatedButton(onPressed: (){
            setState(() {
              loading = true;
            });
            auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                verificationCompleted: (_){
                  setState(() {
                    loading = false;
                  });
                },
                verificationFailed: (e){
                  setState(() {
                    loading = false;
                  });
                  print(e.toString());
                },
                codeSent: (String verificationId, int? token){
                  setState(() {
                    loading = false;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCodeScreen(verificationId: verificationId,)));
                },
                codeAutoRetrievalTimeout: (e){
                  setState(() {
                    loading = false;
                  });
                  print("code autoretrieval timeout => ${e.toString()}");
                });
          }, child: Text("Button"))
        ],
      ),
    );
  }
}
