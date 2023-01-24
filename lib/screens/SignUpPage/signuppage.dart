import 'dart:typed_data';
import 'package:sqqlsoical/Resources/auth_methods.dart';
import 'package:sqqlsoical/Responsive/mobile_screen_layout.dart';
import 'package:sqqlsoical/Responsive/responsive_layout.dart';
import 'package:sqqlsoical/Responsive/web_screen_layout.dart';
import 'package:sqqlsoical/screens/LoginPage/loginpage.dart';
import 'package:sqqlsoical/subpages/SplashScreen/splashscreen.dart';
import 'package:sqqlsoical/utils/colors.dart';
import 'package:sqqlsoical/utils/utils.dart';
import 'package:sqqlsoical/widgets/textfield_input.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool isLoading = false;
  bool _obscureText = true;

  get Isloading => isLoading;
  Uint8List? image;

  get IsImage => image;

  //get getPhoneNumberController => null;

  void toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        //phonenumber: ,
        file: image!,
        phonenumber: '');
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
          const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  selectImage() async {
    try {
      Uint8List im = await pickImage(ImageSource.gallery);
      // set state because we need to display the image we selected on the circle avatar
      setState(() {
        image = im;
      });
    }
    catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* Flexible(
                    child: Container(),
                    flex: 2,
                  ),*/
                  /*SvgPicture.asset(
                    'assets/ic_instagram.svg',
                    color: primaryColor,
                    height: 64,
                  ),*/
            
                  Stack(
                    children: [
                      image != null
                          ? CircleAvatar(
                        radius: 45,
                        backgroundImage: MemoryImage(image!),
                        backgroundColor: Colors.red,
                      )
                          : const CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                            'https://i.stack.imgur.com/l60Hf.png'),
                        backgroundColor: Colors.red,
                      ),
                      Positioned(
                        bottom: -25,
                        left: 71,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo,),
                        ),
                      )
                    ],
                  ),
            
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: TextFieldInput(
                      hintText: 'Enter your username',
                      textInputType: TextInputType.text,
                      textEditingController: _usernameController,
            
                    ),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: TextFieldInput(
                      hintText: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailController,
                    ),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: TextFieldInput(
                      hintText: 'Enter your password',
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController,
                      isPass: _obscureText,
                      /*   passicon: IconButton(onPressed: toggle, icon: _obscureText?Icon(Icons.visibility):Icon(Icons.visibility_off)),
                    ),*/
                    ),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                    child: TextFieldInput(
                      hintText: 'Enter your bio',
                      textInputType: TextInputType.text,
                      textEditingController: _bioController,
                    ),
                  ),
            
                  InkWell(
                    child: Container(
                      child: !isLoading
                          ? const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.00,
                        ),
                      )
                          : const CircularProgressIndicator(
                        color: primaryColor,
                      ),
                      height: 50.00,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.25,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                    onTap: signUpUser,
                  ),
            
                  /*Flexible(
                    child: Container(),
                    flex: 2,
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          'Already have an account?', style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold
                        ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            ),
                        child: Container(
                          child: const Text(
                            ' Login.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ],
                  ),
            
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.03),
                    child: GestureDetector(
                      child: social(10.00,
                        'By Clicking on \'Sign Up\' \nyou agree to Terms and Condition\'s',
                        color: Colors.white,),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
