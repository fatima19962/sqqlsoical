import 'package:sqqlsoical/Resources/auth_methods.dart';
import 'package:sqqlsoical/Responsive/mobile_screen_layout.dart';
import 'package:sqqlsoical/Responsive/responsive_layout.dart';
import 'package:sqqlsoical/Responsive/web_screen_layout.dart';
import 'package:sqqlsoical/screens/HomeScreen/homescreen.dart';
import 'package:sqqlsoical/screens/SignUpPage/signuppage.dart';
import 'package:sqqlsoical/subpages/SplashScreen/splashscreen.dart';
import 'package:sqqlsoical/subpages/phone_authentication/phone_authentication.dart';
import 'package:sqqlsoical/utils/colors.dart';
import 'package:sqqlsoical/utils/utils.dart';
import 'package:sqqlsoical/widgets/richtext.dart';
import 'package:sqqlsoical/widgets/textfield_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future forgetpassword() async {
    try {
      await AuthMethods().passwordReset(
          context, _emailController.text);
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
              (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
     // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
                  [
                   /* Flexible(
                      child: Container(),
                      flex: 3,
                    ),*/
          
          
                        richtext('Anybody',"  Can teach",35.0,Colors.red,),
                        richtext('Everyone',"  Can learn.",35.0,Colors.red,),
          
          
                /*SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),*/
          
                Padding(
                  padding: const EdgeInsets.only(top: 4.0,bottom: 4.0),
                  child: TextFieldInput(
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),
                ),
          
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0,top: 4.0),
                  child: TextFieldInput(
                    hintText: 'Password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
          
                    isPass: _obscureText,
                  /*  passicon: IconButton(onPressed: toggle, icon: _obscureText?Icon(Icons.visibility):Icon(Icons.visibility_off)),*/
                  ),
                ), GestureDetector(
                  onTap: (){
                   if(_emailController.text.isEmpty||_passwordController.text.isEmpty){
                     return showSnackBar(context, "Please fill Information correctly");
                   }
                   else {
                     forgetpassword();
                   }
                  },
                  child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: '                Forget Password ? ',
                            style: TextStyle(
                              fontSize: 15.00,
                              color: Colors.white,
                              //  decoration: TextDecoration.underline,
                            )),
                      ])),
                ),
                   Padding(
             padding: const EdgeInsets.only(top: 4.0),
             child: InkWell(
                    child: Container(
                  child: !_isLoading
                  ? const Text(
                    'Log in', style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.00,
                  ),
                  )
                : const CircularProgressIndicator(
                  color: primaryColor,
                  ),
                  height: 40.00,
                  width: MediaQuery.of(context).size.width * 0.25,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 3, 40, 58),
                Color.fromARGB(255, 223, 19, 4),
              ],
                  ),
                  ),
              ),
                    onTap: loginUser,
                  ),
                   ),
          
                /*Flexible(
                  child: Container(),
                  flex: 2,
                ),*/
                   const  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Or Login Using",style: TextStyle(
                        fontSize: 16.00,color: Colors.white
                      ),),
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 3, 40, 58),
                            Color.fromARGB(255, 223, 19, 4),
                          ],
                        ),
                      ),
                      child: IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginWithPhoneNumber()));
                      }, icon: Icon(Icons.phone,color: Colors.red,)),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 3, 40, 58),
                            Color.fromARGB(255, 223, 19, 4),
                          ],
                        ),
                      ),
                      child: IconButton(onPressed: loginUser, icon: FaIcon(FontAwesomeIcons.google,color: Colors.green,)),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 3, 40, 58),
                            Color.fromARGB(255, 223, 19, 4),
                          ],
                        ),
                      ),
                      child: IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginWithPhoneNumber()));
                      }, icon: FaIcon(FontAwesomeIcons.facebook,color: Colors.blue,)),
                    )
          
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          'Dont have an account ?',
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        ),
                        child: Container(
                          child: const Text(
                            ' Signup.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.red
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
