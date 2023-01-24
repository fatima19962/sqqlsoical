import 'package:sqqlsoical/screens/FeedScreen/feedscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Column(
        children: [
          SizedBox(height: 50.0,),
          TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "6 Digit Code"
            ),
          ),
          SizedBox(height: 80.0,),
          ElevatedButton(onPressed: ()async{

            final credential = PhoneAuthProvider.credential(verificationId: widget.verificationId,
                smsCode: phoneNumberController.text);
            try{
              await auth.signInWithCredential(credential);
              Navigator.push(context, MaterialPageRoute(builder: (context) => FeedScreen()));
            }catch(e){
              print(e.toString());
            }

          }, child: Text("Verify"))
        ],
      ),
    );
  }
}
