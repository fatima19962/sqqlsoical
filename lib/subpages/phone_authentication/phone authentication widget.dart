import 'package:sqqlsoical/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'phone_verify_screen.dart';


class phoneauthenticationwidget extends ChangeNotifier{
bool loading = false;
var varificationId;
final phoneNumberController = TextEditingController();
final auth = FirebaseAuth.instance;
get getPhoneNumberController => phoneNumberController.text;


Widget text(String text,double size){
  return Text(text,style: TextStyle(
      fontSize: size,
      color: Colors.white
  ),);
}

Widget textformfield(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: phoneNumberController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "+91 123-xxx-xxx",
        contentPadding: const EdgeInsets.all(8),
        focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    ),
  );
}

LinearGradient buildLinearGradient() {
  return LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.bottomLeft,
    colors: [
      Color.fromARGB(255, 3, 40, 58),
      Color.fromARGB(255, 223, 19, 4),
    ],
  );
}


phonevarifymechanism (BuildContext context){

        auth.verifyPhoneNumber(
            phoneNumber: phoneNumberController.text,
            verificationCompleted: (_){
              notifyListeners();

                loading = false;

            },
            verificationFailed: (e){
                 loading = false;
       notifyListeners();
              print(e.toString());
            },
            codeSent: (String verificationId, int? token){
             notifyListeners();
                loading = false;

              Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCodeScreen(verificationId: verificationId,)));
            },
            codeAutoRetrievalTimeout: (e){
             notifyListeners();
                loading = false;
              print("code autoretrieval timeout => ${e.toString()}");
            });}
     /* else{
        Text("Please enter phone number properly",style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600
        ),);
      }
    }catch(e){
      showSnackBar(context, e.toString());
    }*/





}
