import 'package:sqqlsoical/Responsive/mobile_screen_layout.dart';
import 'package:sqqlsoical/Responsive/responsive_layout.dart';
import 'package:sqqlsoical/Responsive/web_screen_layout.dart';
import 'package:sqqlsoical/providers/user_provider.dart';
import 'package:sqqlsoical/screens/LoginPage/loginpage.dart';
import 'package:sqqlsoical/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'subpages/SplashScreen/splashscreen.dart';
import 'subpages/phone_authentication/phone authentication widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCp2O-OBdhdKwODEwuGVSC-QqDFPOS_ltk",
          authDomain: "eqlsocial-a647a.firebaseapp.com",
          projectId: "eqqlsoical",
          storageBucket: "eqqlsoical.appspot.com",
          messagingSenderId: "811117522173",
          appId: "1:147359849589:web:fbbca67256e2438872ec3c",
          measurementId: "G-YMVHWG4JTF"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => phoneauthenticationwidget(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'eql.social',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
          ),
          home:
              SplashScreen() /*StreamBuilder(
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
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
          },
        ),*/
          ),
    );
  }
}
