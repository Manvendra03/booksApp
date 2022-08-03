import 'package:notary_app/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:notary_app/custom_colors.dart';

import 'package:notary_app/widgets.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("height : $height");
    print("width : $width");
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Image.asset(
                "Assets/images/thenotary.png",
                height: height * .113,
              ),
            ),
            Spacer(),
            Text(
              'Login Now',
              style: logintextstyle.copyWith(
                  fontSize: width * .10, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Please Enter the details below to continue ",
              style: logintextstyle,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * .009, horizontal: width * .07),
              child: TextField(
                style: logintextstyle.copyWith(fontSize: 17),
                controller: emailController,
                cursorColor: black_color,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: textField_color,
                  filled: true,
                  hintText: "Email",
                ),
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * .009, horizontal: width * .07),
              child: TextField(
                obscureText: true,
                style: TextStyle(fontSize: 19.0, color: black_color),
                controller: passwordController,
                cursorColor: black_color,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: textField_color,
                  filled: true,
                  hintText: "password",
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedLoadingButton(
                controller: buttonController,
                onPressed: () async {
                  String error = await AuthService().logInUserWithEmail(
                      emailController.text, passwordController.text, context);
                  if (error == 'noerror') {
                    showtoast("login successfully");
                    buttonController.reset();
                    Navigator.pushNamed(context, '/dashboard_page_route');
                  } else {
                    checkError(error, context);
                  }
                },
                child: Text("Login")),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void checkError(String errorCode, BuildContext context) {
    if (errorCode == 'unknown') {
      showtoast("Email and Password not be empty");

      buttonController.reset();
    } else if (errorCode == 'network-request-failed') {
      Navigator.pushNamed(context, '/error_page_route');
      buttonController.reset();
    } else if (errorCode == 'invalid-email') {
      showtoast("Invalid Email");
      buttonController.reset();
    } else if (errorCode == 'wrong-password') {
      showtoast("Wrong Password");
      buttonController.reset();
    } else if (errorCode == 'user-not-found') {
      showtoast("Email is not registered yet");
      buttonController.reset();
    } else {
      showtoast("Something went wrong please try later ");
      buttonController.reset();
    }
  }
}





  //  bool result = await InternetConnectionChecker().hasConnection;
  //                 if (result == true) {
  //                   print('YAY! Free cute dog pics!');
  //                 } else {
  //                   print('No internet :( Reason:');
  //                 }