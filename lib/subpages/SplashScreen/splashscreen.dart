import 'package:sqqlsoical/Responsive/mobile_screen_layout.dart';
import 'package:sqqlsoical/Responsive/responsive_layout.dart';
import 'package:sqqlsoical/Responsive/web_screen_layout.dart';
import 'package:sqqlsoical/screens/LoginPage/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 3),()async{
      await Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  // Checking if the snapshot has any data or not
                  if (snapshot.hasData) {
                    // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                    return const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Lottie.asset('lib/assets/animations/loading.json'),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Checking if the snapshot has any data or not
                  if (snapshot.hasData) {
                    // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                    return const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Lottie.asset('lib/assets/animations/loading.json'),
                    );
                  }
                }

                // means connection to future hasnt been made yet
                if (snapshot.connectionState == ConnectionState.none) {
                  return  Center(
                    child: Lottie.asset('lib/assets/animations/loading.json'),
                  );
                }

                return const LoginScreen();
              },
            ),
          ));

    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 3, 40, 58),
                  Color.fromARGB(255, 223, 19, 4),
                ],
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: social(55.00, 'eql.', color: Colors.red),

                  ),
                  Center(
                    child: social(55.00,' Social',color:Colors.white),

                  )
                ]),
          )),
    );
  }
}
Widget social(double size,String text,{required Color color}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color,
    ),
  );
}
